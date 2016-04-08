Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:33011 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbcDHVk2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 8 Apr 2016 17:40:28 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aoe8f-0003Je-4j
	for util-linux@vger.kernel.org; Fri, 08 Apr 2016 23:40:25 +0200
Received: from ppp37-190-56-86.pppoe.spdop.ru ([37.190.56.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 08 Apr 2016 23:40:25 +0200
Received: from yumkam by ppp37-190-56-86.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 08 Apr 2016 23:40:25 +0200
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: [RFC][WIP][PATCH] fsck -l and lvm/dmcrypt/md/etc
Date: Sat, 09 Apr 2016 00:40:18 +0300
Message-ID: <m34mbbrd8d.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain

I think this algorithm should work:

1) walk /dev/block/${dev}/slaves recursively (e.g. lvm-over- luks-
over-lvm- over-md, first-level slaves won't work), collect all
whole-disk devices;
2) sort this list by device numbers (to avoid AB/BA deadlocks), remove
duplicates;
3) acquire all locks consequently.

There are some unavoidable flaws (e.g. if someone alters structure while fsck
is running), and some things could be improved, but it should work in
most cases (and if it fails, it is just no worse than current behavior).

I've tested with LVM and LUKS-over-LVM on (debian's) 3.16 kernel, it seems
works as expected.

What is not covered: /dev/loop* (and I have no plans for it).

Comments? NACKs?


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=fsck--l-dm-md.patch

BEWARE: work-in-progress, and it is full of NIH.

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 84d2dcc..6bd708f 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -100,6 +100,10 @@ struct fsck_fs_data
 			eval_device:1;
 };
 
+union disk_lock {
+	dev_t	dev;
+	int	lock;		/* flock()ed file descriptor or -1 */
+};
 /*
  * Structure to allow exit codes to be stored
  */
@@ -107,8 +111,9 @@ struct fsck_instance {
 	int	pid;
 	int	flags;		/* FLAG_{DONE|PROGRESS} */
 
-	int	lock;		/* flock()ed lockpath file descriptor or -1 */
-	char	*lockpath;	/* /run/fsck/<diskname>.lock or NULL */
+
+	union disk_lock *locks, lock;
+	size_t nlocks;
 
 	int	exit_status;
 	struct timeval start_time;
@@ -335,19 +340,25 @@ static int is_irrotational_disk(dev_t disk)
 	return rc == 1 ? !x : 0;
 }
 
+static int compare_locks(const void *a, const void *b)
+{
+	dev_t a_dev = ((const union disk_lock *)a)->dev;
+	dev_t b_dev = ((const union disk_lock *)b)->dev;
+	return (a_dev > b_dev) - (b_dev > a_dev);
+}
+
 static void lock_disk(struct fsck_instance *inst)
 {
 	dev_t disk = fs_get_disk(inst->fs, 1);
 	char *diskpath = NULL, *diskname;
-
-	inst->lock = -1;
+	union disk_lock *locks = NULL;
+	size_t nlocks = 0;
+	size_t i;
+	char path[PATH_MAX];
+	int rc;
 
 	if (!disk || is_irrotational_disk(disk))
-		goto done;
-
-	diskpath = blkid_devno_to_devname(disk);
-	if (!diskpath)
-		goto done;
+		return;
 
 	if (access(FSCK_RUNTIME_DIRNAME, F_OK) != 0) {
 		int rc = mkdir(FSCK_RUNTIME_DIRNAME,
@@ -357,64 +368,151 @@ static void lock_disk(struct fsck_instance *inst)
 		if (rc && errno != EEXIST) {
 			warn(_("cannot create directory %s"),
 					FSCK_RUNTIME_DIRNAME);
-			goto done;
+			return;
 		}
 	}
 
+	if (fs_is_stacked(inst->fs)) {
+		/* XXX this code (gracefully) ignores errors */
+		size_t allocated = 4;
+	       	locks = malloc(allocated*sizeof(union disk_lock));
+		locks[nlocks++].dev = disk;
+		for(i = 0; i < nlocks; i++) {
+			size_t path_end;
+			DIR *dir;
+			struct dirent *dp;
+			size_t j;
+
+			disk = locks[i].dev;
+			rc = snprintf(path, sizeof(path),
+					"/sys/dev/block/%d:%d/slaves",
+					major(disk), minor(disk));
+			if (rc < 0 || (unsigned int) rc >= sizeof(path))
+				continue;
+			path_end = rc;
+			if ((dir = opendir(path)) == NULL)
+				continue;
+			while((dp = readdir(dir)) != NULL) {
+				FILE *f;
+				int maj, min;
+#ifdef _DIRENT_HAVE_D_TYPE
+				if (dp->d_type != DT_UNKNOWN &&
+				    dp->d_type != DT_LNK)
+					continue;
+#endif
+				if (dp->d_name[0] == '.' &&
+				    ((dp->d_name[1] == 0) ||
+				    ((dp->d_name[1] == '.') && (dp->d_name[2] == 0))))
+					continue;
+				rc = snprintf(path + path_end,
+					       sizeof(path) - path_end,
+					       "/%s/dev", dp->d_name);
+				if (rc < 0 || (unsigned int)rc >= sizeof(path) - path_end)
+					continue;
+
+				if ((f = fopen(path, "r")) == NULL)
+					continue;
+				rc = fscanf(f, "%d:%d", &maj, &min);
+				fclose(f);
+				if (rc != 2)
+					continue;
+
+				disk = makedev(maj, min);
+				if (blkid_devno_to_wholedisk(disk, NULL, 0, &disk))
+					continue;;
+				for (j = nlocks; j > 0; j--) {
+					/* XXX O(n^2) */
+					if (disk == locks[j-1].dev)
+						break;
+				}
+				if (j > 0) /* Don't add duplicates */
+					continue;;
+				if (is_irrotational_disk(disk))
+					continue;;
+				if (allocated >= nlocks) {
+					void *p;
+					if (allocated > INT_MAX/(2*sizeof(locks[0])))
+						continue;;
+					p = realloc(locks, allocated*2*sizeof(locks[0]));
+					if (p == NULL)
+						continue;;
+					locks = p;
+					allocated *= 2;
+				}
+				locks[nlocks++].dev = disk;
+			}
+			closedir(dir);
+		}
+		qsort(locks, nlocks, sizeof(locks[0]), compare_locks);
+		locks = realloc(locks, nlocks*sizeof(locks[0]));
+	} else {
+		inst->lock.dev = disk;
+		locks = &inst->lock;
+		nlocks = 1;
+	}
+	inst->locks = locks;
+	inst->nlocks = nlocks;
+
+	for (i = 0; i < nlocks; i++) {
+		disk = locks[i].dev;
+	diskpath = blkid_devno_to_devname(disk);
+	if (!diskpath) {
+		locks[i].lock = -1;
+		continue;
+	}
+	/* XXX is this necessary? E.g. why not replace with ..."/%d_%d.lock", major(), minor()); */
 	diskname = stripoff_last_component(diskpath);
 	if (!diskname)
 		diskname = diskpath;
 
-	xasprintf(&inst->lockpath, FSCK_RUNTIME_DIRNAME "/%s.lock", diskname);
+	rc = snprintf(path, sizeof(path), FSCK_RUNTIME_DIRNAME "/%s.lock", diskname);
+	if (rc < 0 || (unsigned int)rc >= sizeof(path)) {
+		locks[i].lock = -1;
+		free(diskpath);
+		continue;
+	}
 
 	if (verbose)
-		printf(_("Locking disk by %s ... "), inst->lockpath);
+		printf(_("Locking disk %d:%d by %s ... "),
+			major(disk), minor(disk), path);
 
-	inst->lock = open(inst->lockpath, O_RDONLY|O_CREAT|O_CLOEXEC,
+	locks[i].lock = open(path, O_RDONLY|O_CREAT|O_CLOEXEC,
 				    S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
-	if (inst->lock >= 0) {
+	if (locks[i].lock >= 0) {
 		int rc = -1;
 
 		/* inform users that we're waiting on the lock */
 		if (verbose &&
-		    (rc = flock(inst->lock, LOCK_EX | LOCK_NB)) != 0 &&
+		    (rc = flock(locks[i].lock, LOCK_EX | LOCK_NB)) != 0 &&
 		    errno == EWOULDBLOCK)
 			printf(_("(waiting) "));
 
-		if (rc != 0 && flock(inst->lock, LOCK_EX) != 0) {
-			close(inst->lock);			/* failed */
-			inst->lock = -1;
+		if (rc != 0 && flock(locks[i].lock, LOCK_EX) != 0) {
+			close(locks[i].lock);			/* failed */
+			locks[i].lock = -1;
 		}
 	}
 
 	if (verbose)
 		/* TRANSLATORS: These are followups to "Locking disk...". */
-		printf("%s.\n", inst->lock >= 0 ? _("succeeded") : _("failed"));
+		printf("%s.\n", locks[i].lock >= 0 ? _("succeeded") : _("failed"));
 
-
-done:
-	if (inst->lock < 0) {
-		free(inst->lockpath);
-		inst->lockpath = NULL;
-	}
 	free(diskpath);
+	}
 	return;
 }
 
 static void unlock_disk(struct fsck_instance *inst)
 {
-	if (inst->lock < 0)
-		return;
 
 	if (verbose)
-		printf(_("Unlocking %s.\n"), inst->lockpath);
-
-	close(inst->lock);			/* unlock */
-
-	free(inst->lockpath);
+		printf(_("Unlocking disks.\n"));
 
-	inst->lock = -1;
-	inst->lockpath = NULL;
+	while(inst->nlocks > 0)
+		close(inst->locks[--(inst->nlocks)].lock);	/* unlock */
+	if (inst->locks != &inst->lock)
+		free(inst->locks);
+	inst->locks = NULL;
 }
 
 static void free_instance(struct fsck_instance *i)
@@ -422,7 +520,8 @@ static void free_instance(struct fsck_instance *i)
 	if (lockdisk)
 		unlock_disk(i);
 	free(i->prog);
-	free(i->lockpath);
+	if (i->locks != &i->lock)
+		free(i->locks);
 	mnt_unref_fs(i->fs);
 	free(i);
 	return;
@@ -469,7 +568,7 @@ static void fs_interpret_type(struct libmnt_fs *fs)
 static int parser_errcb(struct libmnt_table *tb __attribute__ ((__unused__)),
 			const char *filename, int line)
 {
-	warnx(_("%s: parse error at line %d -- ignored"), filename, line);
+	warnx(_("%s: parse error at line %d -- ignore"), filename, line);
 	return 1;
 }
 
@@ -666,7 +765,8 @@ static int execute(const char *progname, const char *progpath,
 
 	mnt_ref_fs(fs);
 	inst->fs = fs;
-	inst->lock = -1;
+	inst->locks = NULL;
+	inst->nlocks = 0;
 
 	if (lockdisk)
 		lock_disk(inst);

--=-=-=--

