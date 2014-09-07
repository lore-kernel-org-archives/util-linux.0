Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:59137 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbaIGMnm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:42 -0400
Received: by mail-wi0-f176.google.com with SMTP id bs8so1365958wib.9
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/17] eject: add struct eject_control to remove global variables
Date: Sun,  7 Sep 2014 13:43:00 +0100
Message-Id: <1410093785-17537-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c | 394 +++++++++++++++++++++++++++---------------------------
 1 file changed, 198 insertions(+), 196 deletions(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 03744c7..767ede7 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -81,31 +81,34 @@ static const char * const hotplug_subsystems[] = {
 	"ccw"
 };
 
-/* Global Variables */
-static int a_option; /* command flags and arguments */
-static int c_option;
-static int d_option;
-static int f_option;
-static int F_option;
-static int n_option;
-static int q_option;
-static int r_option;
-static int s_option;
-static int t_option;
-static int T_option;
-static int X_option;
-static int v_option;
-static int x_option;
-static int p_option;
-static int m_option;
-static int M_option;
-static int i_option;
-static int a_arg;
-static int i_arg;
-static long int c_arg;
-static long int x_arg;
-
-struct libmnt_table *mtab;
+struct eject_control {
+	struct libmnt_table *mtab;
+	char *device;			/* device or mount point to be ejected */
+	int fd;				/* file descriptor for device */
+	uint32_t 			/* command flags and arguments */
+		a_option:1,
+		c_option:1,
+		d_option:1,
+		F_option:1,
+		f_option:1,
+		i_option:1,
+		M_option:1,
+		m_option:1,
+		n_option:1,
+		p_option:1,
+		q_option:1,
+		r_option:1,
+		s_option:1,
+		T_option:1,
+		t_option:1,
+		v_option:1,
+		X_option:1,
+		x_option:1,
+		a_arg:1,
+		i_arg:1;
+	long int c_arg;			/* changer slot number */
+	long int x_arg;			/* cd speed */
+};
 
 static void vinfo(const char *fmt, va_list va)
 {
@@ -114,11 +117,11 @@ static void vinfo(const char *fmt, va_list va)
 	fputc('\n', stdout);
 }
 
-static inline void verbose(const char *fmt, ...)
+static inline void verbose(const struct eject_control *ctl, const char *fmt, ...)
 {
 	va_list va;
 
-	if (!v_option)
+	if (!ctl->v_option)
 		return;
 
 	va_start(va, fmt);
@@ -174,7 +177,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 
 
 /* Handle command line options. */
-static void parse_args(int argc, char **argv, char **device)
+static void parse_args(struct eject_control *ctl, int argc, char **argv)
 {
 	static const struct option long_opts[] =
 	{
@@ -206,75 +209,75 @@ static void parse_args(int argc, char **argv, char **device)
 				"a:c:i:x:dfFhnqrstTXvVpmM", long_opts, NULL)) != -1) {
 		switch (c) {
 		case 'a':
-			a_option = 1;
+			ctl->a_option = 1;
 			if (!strcmp(optarg, "0") || !strcmp(optarg, "off"))
-				a_arg = 0;
+				ctl->a_arg = 0;
 			else if (!strcmp(optarg, "1") || !strcmp(optarg, "on"))
-				a_arg = 1;
+				ctl->a_arg = 1;
 			else
 				errx(EXIT_FAILURE, _("invalid argument to --auto/-a option"));
 			break;
 		case 'c':
-			c_option = 1;
-			c_arg = strtoul_or_err(optarg, _("invalid argument to --changerslot/-c option"));
+			ctl->c_option = 1;
+			ctl->c_arg = strtoul_or_err(optarg, _("invalid argument to --changerslot/-c option"));
 			break;
 		case 'x':
-			x_option = 1;
-			x_arg = strtoul_or_err(optarg, _("invalid argument to --cdspeed/-x option"));
+			ctl->x_option = 1;
+			ctl->x_arg = strtoul_or_err(optarg, _("invalid argument to --cdspeed/-x option"));
 			break;
 		case 'd':
-			d_option = 1;
+			ctl->d_option = 1;
 			break;
 		case 'f':
-			f_option = 1;
+			ctl->f_option = 1;
 			break;
 		case 'F':
-			F_option = 1;
+			ctl->F_option = 1;
 			break;
 		case 'h':
 			usage(stdout);
 			break;
 		case 'i':
-			i_option = 1;
+			ctl->i_option = 1;
 			if (!strcmp(optarg, "0") || !strcmp(optarg, "off"))
-				i_arg = 0;
+				ctl->i_arg = 0;
 			else if (!strcmp(optarg, "1") || !strcmp(optarg, "on"))
-				i_arg = 1;
+				ctl->i_arg = 1;
 			else
 				errx(EXIT_FAILURE, _("invalid argument to --manualeject/-i option"));
 			break;
 		case 'm':
-			m_option = 1;
+			ctl->m_option = 1;
 			break;
 		case 'M':
-			M_option = 1;
+			ctl->M_option = 1;
 			break;
 		case 'n':
-			n_option = 1;
+			ctl->n_option = 1;
 			break;
 		case 'p':
-			p_option = 1;
+			ctl->p_option = 1;
 			break;
 		case 'q':
-			q_option = 1;
+			ctl->q_option = 1;
 			break;
 		case 'r':
-			r_option = 1;
+			ctl->r_option = 1;
 			break;
 		case 's':
-			s_option = 1;
+			ctl->s_option = 1;
 			break;
 		case 't':
-			t_option = 1;
+			ctl->t_option = 1;
 			break;
 		case 'T':
-			T_option = 1;
+			ctl->T_option = 1;
 			break;
 		case 'X':
-			X_option = 1;
+			ctl->X_option = 1;
 			break;
 		case 'v':
-			v_option = 1;
+			ctl->v_option = 1;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -292,7 +295,7 @@ static void parse_args(int argc, char **argv, char **device)
 		errx(EXIT_FAILURE, _("too many arguments"));
 
 	if ((argc - optind) == 1)
-		*device = xstrdup(argv[optind]);
+		ctl->device = xstrdup(argv[optind]);
 }
 
 /*
@@ -323,15 +326,15 @@ static char *find_device(const char *name)
 }
 
 /* Set or clear auto-eject mode. */
-static void auto_eject(int fd, int on)
+static void auto_eject(const struct eject_control *ctl)
 {
 	int status = -1;
 
 #if defined(CDROM_SET_OPTIONS) && defined(CDROM_CLEAR_OPTIONS)
-	if (on)
-		status = ioctl(fd, CDROM_SET_OPTIONS, CDO_AUTO_EJECT);
+	if (ctl->a_arg)
+		status = ioctl(ctl->fd, CDROM_SET_OPTIONS, CDO_AUTO_EJECT);
 	else
-		status = ioctl(fd, CDROM_CLEAR_OPTIONS, CDO_AUTO_EJECT);
+		status = ioctl(ctl->fd, CDROM_CLEAR_OPTIONS, CDO_AUTO_EJECT);
 #else
 	errno = ENOSYS;
 #endif
@@ -350,12 +353,12 @@ static void auto_eject(int fd, int on)
  * EBUSY                 Attempt to unlock when multiple users
  *                       have the drive open and not CAP_SYS_ADMIN
  */
-static void manual_eject(int fd, int on)
+static void manual_eject(const struct eject_control *ctl)
 {
-	if (ioctl(fd, CDROM_LOCKDOOR, on) < 0)
+	if (ioctl(ctl->fd, CDROM_LOCKDOOR, ctl->i_arg) < 0)
 		err(EXIT_FAILURE, _("CD-ROM lock door command failed"));
 
-	if (on)
+	if (ctl->i_arg)
 		info(_("CD-Drive may NOT be ejected with device button"));
 	else
 		info(_("CD-Drive may be ejected with device button"));
@@ -365,14 +368,14 @@ static void manual_eject(int fd, int on)
  * Changer select. CDROM_SELECT_DISC is preferred, older kernels used
  * CDROMLOADFROMSLOT.
  */
-static void changer_select(int fd, int slot)
+static void changer_select(const struct eject_control *ctl)
 {
 #ifdef CDROM_SELECT_DISC
-	if (ioctl(fd, CDROM_SELECT_DISC, slot) < 0)
+	if (ioctl(ctl->fd, CDROM_SELECT_DISC, ctl->c_arg) < 0)
 		err(EXIT_FAILURE, _("CD-ROM select disc command failed"));
 
 #elif defined CDROMLOADFROMSLOT
-	if (ioctl(fd, CDROMLOADFROMSLOT, slot) != 0)
+	if (ioctl(ctl->fd, CDROMLOADFROMSLOT, ctl->c_arg) != 0)
 		err(EXIT_FAILURE, _("CD-ROM load from slot command failed"));
 #else
 	warnx(_("IDE/ATAPI CD-ROM changer not supported by this kernel\n") );
@@ -557,18 +560,18 @@ static int read_speed(const char *devname)
 /*
  * List Speed of CD-ROM drive.
  */
-static void list_speeds(const char *name, int fd)
+static void list_speeds(const struct eject_control *ctl)
 {
 #ifdef CDROM_SELECT_SPEED
 	int max_speed, curr_speed = 0, prev_speed;
 
-	select_speed(fd, 0);
-	max_speed = read_speed(name);
+	select_speed(ctl->fd, 0);
+	max_speed = read_speed(ctl->device);
 
 	while (curr_speed < max_speed) {
 		prev_speed = curr_speed;
-		select_speed(fd, prev_speed + 1);
-		curr_speed = read_speed(name);
+		select_speed(ctl->fd, prev_speed + 1);
+		curr_speed = read_speed(ctl->device);
 		if (curr_speed > prev_speed)
 			printf("%d ", curr_speed);
 		else
@@ -584,7 +587,7 @@ static void list_speeds(const char *name, int fd)
 /*
  * Eject using SCSI SG_IO commands. Return 1 if successful, 0 otherwise.
  */
-static int eject_scsi(int fd)
+static int eject_scsi(const struct eject_control *ctl)
 {
 	int status, k;
 	sg_io_hdr_t io_hdr;
@@ -594,8 +597,8 @@ static int eject_scsi(int fd)
 	unsigned char inqBuff[2];
 	unsigned char sense_buffer[32];
 
-	if ((ioctl(fd, SG_GET_VERSION_NUM, &k) < 0) || (k < 30000)) {
-		verbose(_("not an sg device, or old sg driver"));
+	if ((ioctl(ctl->fd, SG_GET_VERSION_NUM, &k) < 0) || (k < 30000)) {
+		verbose(ctl, _("not an sg device, or old sg driver"));
 		return 0;
 	}
 
@@ -610,12 +613,12 @@ static int eject_scsi(int fd)
 	io_hdr.timeout = 10000;
 
 	io_hdr.cmdp = allowRmBlk;
-	status = ioctl(fd, SG_IO, (void *)&io_hdr);
+	status = ioctl(ctl->fd, SG_IO, (void *)&io_hdr);
 	if (status < 0 || io_hdr.host_status || io_hdr.driver_status)
 		return 0;
 
 	io_hdr.cmdp = startStop1Blk;
-	status = ioctl(fd, SG_IO, (void *)&io_hdr);
+	status = ioctl(ctl->fd, SG_IO, (void *)&io_hdr);
 	if (status < 0 || io_hdr.host_status)
 		return 0;
 
@@ -630,12 +633,12 @@ static int eject_scsi(int fd)
 		return 0;
 
 	io_hdr.cmdp = startStop2Blk;
-	status = ioctl(fd, SG_IO, (void *)&io_hdr);
+	status = ioctl(ctl->fd, SG_IO, (void *)&io_hdr);
 	if (status < 0 || io_hdr.host_status || io_hdr.driver_status)
 		return 0;
 
 	/* force kernel to reread partition table when new disc inserted */
-	ioctl(fd, BLKRRPART);
+	ioctl(ctl->fd, BLKRRPART);
 	return 1;
 }
 
@@ -660,14 +663,14 @@ static int eject_tape(int fd)
 
 
 /* umount a device. */
-static void umount_one(const char *name)
+static void umount_one(const struct eject_control *ctl, const char *name)
 {
 	int status;
 
 	if (!name)
 		return;
 
-	verbose(_("%s: unmounting"), name);
+	verbose(ctl, _("%s: unmounting"), name);
 
 	switch (fork()) {
 	case 0: /* child */
@@ -677,7 +680,7 @@ static void umount_one(const char *name)
 		if (setuid(getuid()) < 0)
 			err(EXIT_FAILURE, _("cannot set user id"));
 
-		if (p_option)
+		if (ctl->p_option)
 			execl("/bin/umount", "/bin/umount", name, "-n", NULL);
 		else
 			execl("/bin/umount", "/bin/umount", name, NULL);
@@ -716,36 +719,36 @@ static int open_device(const char *name)
  * See if device has been mounted by looking in mount table.  If so, set
  * device name and mount point name, and return 1, otherwise return 0.
  */
-static int device_get_mountpoint(char **devname, char **mnt)
+static int device_get_mountpoint(struct eject_control *ctl, char **devname, char **mnt)
 {
 	struct libmnt_fs *fs;
 	int rc;
 
 	*mnt = NULL;
 
-	if (!mtab) {
+	if (!ctl->mtab) {
 		struct libmnt_cache *cache;
 
-		mtab = mnt_new_table();
-		if (!mtab)
+		ctl->mtab = mnt_new_table();
+		if (!ctl->mtab)
 			err(EXIT_FAILURE, _("failed to initialize libmount table"));
 
 		cache = mnt_new_cache();
-		mnt_table_set_cache(mtab, cache);
+		mnt_table_set_cache(ctl->mtab, cache);
 		mnt_unref_cache(cache);
 
-		if (p_option)
-			rc = mnt_table_parse_file(mtab, _PATH_PROC_MOUNTINFO);
+		if (ctl->p_option)
+			rc = mnt_table_parse_file(ctl->mtab, _PATH_PROC_MOUNTINFO);
 		else
-			rc = mnt_table_parse_mtab(mtab, NULL);
+			rc = mnt_table_parse_mtab(ctl->mtab, NULL);
 		if (rc)
 			err(EXIT_FAILURE, _("failed to parse mount table"));
 	}
 
-	fs = mnt_table_find_source(mtab, *devname, MNT_ITER_BACKWARD);
+	fs = mnt_table_find_source(ctl->mtab, *devname, MNT_ITER_BACKWARD);
 	if (!fs) {
 		/* maybe 'devname' is mountpoint rather than a real device */
-		fs = mnt_table_find_target(mtab, *devname, MNT_ITER_BACKWARD);
+		fs = mnt_table_find_target(ctl->mtab, *devname, MNT_ITER_BACKWARD);
 		if (fs) {
 			free(*devname);
 			*devname = xstrdup(mnt_fs_get_source(fs));
@@ -774,7 +777,7 @@ static char *get_disk_devname(const char *device)
 	return st.st_rdev == diskno ? NULL : find_device(diskname);
 }
 
-static int umount_partitions(const char *disk, int checkonly)
+static int umount_partitions(struct eject_control *ctl)
 {
 	struct sysfs_cxt cxt = UL_SYSFSCXT_EMPTY;
 	dev_t devno;
@@ -782,7 +785,7 @@ static int umount_partitions(const char *disk, int checkonly)
 	struct dirent *d;
 	int count = 0;
 
-	devno = sysfs_devname_to_devno(disk, NULL);
+	devno = sysfs_devname_to_devno(ctl->device, NULL);
 	if (sysfs_init(&cxt, devno, NULL) != 0)
 		return 0;
 
@@ -795,14 +798,14 @@ static int umount_partitions(const char *disk, int checkonly)
 		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 			continue;
 
-		if (sysfs_is_partition_dirent(dir, d, disk)) {
+		if (sysfs_is_partition_dirent(dir, d, ctl->device)) {
 			char *mnt = NULL;
 			char *dev = find_device(d->d_name);
 
-			if (dev && device_get_mountpoint(&dev, &mnt) == 0) {
-				verbose(_("%s: mounted on %s"), dev, mnt);
-				if (!checkonly)
-					umount_one(mnt);
+			if (dev && device_get_mountpoint(ctl, &dev, &mnt) == 0) {
+				verbose(ctl, _("%s: mounted on %s"), dev, mnt);
+				if (!ctl->M_option)
+					umount_one(ctl, mnt);
 				count++;
 			}
 			free(dev);
@@ -881,7 +884,7 @@ static char *get_subsystem(char *chain, char *buf, size_t bufsz)
 	return NULL;
 }
 
-static int is_hotpluggable(const char* device)
+static int is_hotpluggable(const struct eject_control *ctl)
 {
 	struct sysfs_cxt cxt = UL_SYSFSCXT_EMPTY;
 	char devchain[PATH_MAX];
@@ -891,13 +894,13 @@ static int is_hotpluggable(const char* device)
 	ssize_t sz;
 	char *sub;
 
-	devno = sysfs_devname_to_devno(device, NULL);
+	devno = sysfs_devname_to_devno(ctl->device, NULL);
 	if (sysfs_init(&cxt, devno, NULL) != 0)
 		return 0;
 
 	/* check /sys/dev/block/<maj>:<min>/removable attribute */
 	if (sysfs_read_int(&cxt, "removable", &rc) == 0 && rc == 1) {
-		verbose(_("%s: is removable device"), device);
+		verbose(ctl, _("%s: is removable device"), ctl->device);
 		goto done;
 	}
 
@@ -916,8 +919,8 @@ static int is_hotpluggable(const char* device)
 	while ((sub = get_subsystem(devchain, subbuf, sizeof(subbuf)))) {
 		rc = is_hotpluggable_subsystem(sub);
 		if (rc) {
-			verbose(_("%s: connected by hotplug subsystem: %s"),
-				device, sub);
+			verbose(ctl, _("%s: connected by hotplug subsystem: %s"),
+				ctl->device, sub);
 			break;
 		}
 	}
@@ -929,20 +932,20 @@ done:
 
 
 /* handle -x option */
-static void set_device_speed(char *name)
+static void set_device_speed(const struct eject_control *ctl)
 {
 	int fd;
 
-	if (!x_option)
+	if (!ctl->x_option)
 		return;
 
-	if (x_arg == 0)
-		verbose(_("setting CD-ROM speed to auto"));
+	if (ctl->x_arg == 0)
+		verbose(ctl, _("setting CD-ROM speed to auto"));
 	else
-		verbose(_("setting CD-ROM speed to %ldX"), x_arg);
+		verbose(ctl, _("setting CD-ROM speed to %ldX"), ctl->x_arg);
 
-	fd = open_device(name);
-	select_speed(fd, x_arg);
+	fd = open_device(ctl->device);
+	select_speed(fd, ctl->x_arg);
 	exit(EXIT_SUCCESS);
 }
 
@@ -950,11 +953,10 @@ static void set_device_speed(char *name)
 /* main program */
 int main(int argc, char **argv)
 {
-	char *device = NULL;
 	char *disk = NULL;
 	char *mountpoint = NULL;
 	int worked = 0;    /* set to 1 when successfully ejected */
-	int fd;            /* file descriptor for device */
+	struct eject_control ctl = { 0 };
 
 	setlocale(LC_ALL,"");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -962,118 +964,118 @@ int main(int argc, char **argv)
 	atexit(close_stdout);
 
 	/* parse the command line arguments */
-	parse_args(argc, argv, &device);
+	parse_args(&ctl, argc, argv);
 
 	/* handle -d option */
-	if (d_option) {
+	if (ctl.d_option) {
 		info(_("default device: `%s'"), EJECT_DEFAULT_DEVICE);
 		return EXIT_SUCCESS;
 	}
 
-	if (!device) {
-		device = mnt_resolve_path(EJECT_DEFAULT_DEVICE, NULL);
-		verbose(_("using default device `%s'"), device);
+	if (!ctl.device) {
+		ctl.device = mnt_resolve_path(EJECT_DEFAULT_DEVICE, NULL);
+		verbose(&ctl, _("using default device `%s'"), ctl.device);
 	} else {
 		char *p;
 
-		if (device[strlen(device)-1] == '/')
-			device[strlen(device)-1] = '\0';
+		if (ctl.device[strlen(ctl.device) - 1] == '/')
+			ctl.device[strlen(ctl.device) - 1] = '\0';
 
 		/* figure out full device or mount point name */
-		p = find_device(device);
+		p = find_device(ctl.device);
 		if (p)
-			free(device);
+			free(ctl.device);
 		else
-			p = device;
+			p = ctl.device;
 
-		device = mnt_resolve_spec(p, NULL);
+		ctl.device = mnt_resolve_spec(p, NULL);
 		free(p);
 	}
 
-	if (!device)
-		errx(EXIT_FAILURE, _("%s: unable to find device"), device);
+	if (!ctl.device)
+		errx(EXIT_FAILURE, _("%s: unable to find device"), ctl.device);
 
-	verbose(_("device name is `%s'"), device);
+	verbose(&ctl, _("device name is `%s'"), ctl.device);
 
-	device_get_mountpoint(&device, &mountpoint);
+	device_get_mountpoint(&ctl, &ctl.device, &mountpoint);
 	if (mountpoint)
-		verbose(_("%s: mounted on %s"), device, mountpoint);
+		verbose(&ctl, _("%s: mounted on %s"), ctl.device, mountpoint);
 	else
-		verbose(_("%s: not mounted"), device);
+		verbose(&ctl, _("%s: not mounted"), ctl.device);
 
-	disk = get_disk_devname(device);
+	disk = get_disk_devname(ctl.device);
 	if (disk) {
-		verbose(_("%s: disc device: %s (disk device will be used for eject)"), device, disk);
-		free(device);
-		device = disk;
+		verbose(&ctl, _("%s: disc device: %s (disk device will be used for eject)"), ctl.device, disk);
+		free(ctl.device);
+		ctl.device = disk;
 		disk = NULL;
 	} else {
 		struct stat st;
 
-		if (stat(device, &st) != 0 || !S_ISBLK(st.st_mode))
+		if (stat(ctl.device, &st) != 0 || !S_ISBLK(st.st_mode))
 			errx(EXIT_FAILURE, _("%s: not found mountpoint or device "
-					"with the given name"), device);
+					"with the given name"), ctl.device);
 
-		verbose(_("%s: is whole-disk device"), device);
+		verbose(&ctl, _("%s: is whole-disk device"), ctl.device);
 	}
 
-	if (F_option == 0 && is_hotpluggable(device) == 0)
-		errx(EXIT_FAILURE, _("%s: is not hot-pluggable device"), device);
+	if (ctl.F_option == 0 && is_hotpluggable(&ctl) == 0)
+		errx(EXIT_FAILURE, _("%s: is not hot-pluggable device"), ctl.device);
 
 	/* handle -n option */
-	if (n_option) {
-		info(_("device is `%s'"), device);
-		verbose(_("exiting due to -n/--noop option"));
+	if (ctl.n_option) {
+		info(_("device is `%s'"), ctl.device);
+		verbose(&ctl, _("exiting due to -n/--noop option"));
 		return EXIT_SUCCESS;
 	}
 
 	/* handle -i option */
-	if (i_option) {
-		fd = open_device(device);
-		manual_eject(fd, i_arg);
+	if (ctl.i_option) {
+		ctl.fd = open_device(ctl.device);
+		manual_eject(&ctl);
 		return EXIT_SUCCESS;
 	}
 
 	/* handle -a option */
-	if (a_option) {
-		if (a_arg)
-			verbose(_("%s: enabling auto-eject mode"), device);
+	if (ctl.a_option) {
+		if (ctl.a_arg)
+			verbose(&ctl, _("%s: enabling auto-eject mode"), ctl.device);
 		else
-			verbose(_("%s: disabling auto-eject mode"), device);
-		fd = open_device(device);
-		auto_eject(fd, a_arg);
+			verbose(&ctl, _("%s: disabling auto-eject mode"), ctl.device);
+		ctl.fd = open_device(ctl.device);
+		auto_eject(&ctl);
 		return EXIT_SUCCESS;
 	}
 
 	/* handle -t option */
-	if (t_option) {
-		verbose(_("%s: closing tray"), device);
-		fd = open_device(device);
-		close_tray(fd);
-		set_device_speed(device);
+	if (ctl.t_option) {
+		verbose(&ctl, _("%s: closing tray"), ctl.device);
+		ctl.fd = open_device(ctl.device);
+		close_tray(ctl.fd);
+		set_device_speed(&ctl);
 		return EXIT_SUCCESS;
 	}
 
 	/* handle -T option */
-	if (T_option) {
-		verbose(_("%s: toggling tray"), device);
-		fd = open_device(device);
-		toggle_tray(fd);
-		set_device_speed(device);
+	if (ctl.T_option) {
+		verbose(&ctl, _("%s: toggling tray"), ctl.device);
+		ctl.fd = open_device(ctl.device);
+		toggle_tray(ctl.fd);
+		set_device_speed(&ctl);
 		return EXIT_SUCCESS;
 	}
 
 	/* handle -X option */
-	if (X_option) {
-		verbose(_("%s: listing CD-ROM speed"), device);
-		fd = open_device(device);
-		list_speeds(device, fd);
+	if (ctl.X_option) {
+		verbose(&ctl, _("%s: listing CD-ROM speed"), ctl.device);
+		ctl.fd = open_device(ctl.device);
+		list_speeds(&ctl);
 		return EXIT_SUCCESS;
 	}
 
 	/* handle -x option only */
-	if (!c_option)
-		set_device_speed(device);
+	if (!ctl.c_option)
+		set_device_speed(&ctl);
 
 
 	/*
@@ -1081,62 +1083,62 @@ int main(int argc, char **argv)
 	 * mountpoint if -M is specified, otherwise print error of another
 	 * partition is mounted.
 	 */
-	if (!m_option) {
-		int ct = umount_partitions(device, M_option);
+	if (!ctl.m_option) {
+		int ct = umount_partitions(&ctl);
 
 		if (ct == 0 && mountpoint)
-			umount_one(mountpoint); /* probably whole-device */
+			umount_one(&ctl, mountpoint); /* probably whole-device */
 
-		if (M_option) {
+		if (ctl.M_option) {
 			if (ct == 1 && mountpoint)
-				umount_one(mountpoint);
+				umount_one(&ctl, mountpoint);
 			else if (ct)
-				errx(EXIT_FAILURE, _("error: %s: device in use"), device);
+				errx(EXIT_FAILURE, _("error: %s: device in use"), ctl.device);
 		}
 	}
 
 	/* handle -c option */
-	if (c_option) {
-		verbose(_("%s: selecting CD-ROM disc #%ld"), device, c_arg);
-		fd = open_device(device);
-		changer_select(fd, c_arg);
-		set_device_speed(device);
+	if (ctl.c_option) {
+		verbose(&ctl, _("%s: selecting CD-ROM disc #%ld"), ctl.device, ctl.c_arg);
+		ctl.fd = open_device(ctl.device);
+		changer_select(&ctl);
+		set_device_speed(&ctl);
 		return EXIT_SUCCESS;
 	}
 
 	/* if user did not specify type of eject, try all four methods */
-	if (r_option + s_option + f_option + q_option == 0)
-		r_option = s_option = f_option = q_option = 1;
+	if (ctl.r_option + ctl.s_option + ctl.f_option + ctl.q_option == 0)
+		ctl.r_option = ctl.s_option = ctl.f_option = ctl.q_option = 1;
 
 	/* open device */
-	fd = open_device(device);
+	ctl.fd = open_device(ctl.device);
 
 	/* try various methods of ejecting until it works */
-	if (r_option) {
-		verbose(_("%s: trying to eject using CD-ROM eject command"), device);
-		worked = eject_cdrom(fd);
-		verbose(worked ? _("CD-ROM eject command succeeded") :
+	if (ctl.r_option) {
+		verbose(&ctl, _("%s: trying to eject using CD-ROM eject command"), ctl.device);
+		worked = eject_cdrom(ctl.fd);
+		verbose(&ctl, worked ? _("CD-ROM eject command succeeded") :
 				 _("CD-ROM eject command failed"));
 	}
 
-	if (s_option && !worked) {
-		verbose(_("%s: trying to eject using SCSI commands"), device);
-		worked = eject_scsi(fd);
-		verbose(worked ? _("SCSI eject succeeded") :
+	if (ctl.s_option && !worked) {
+		verbose(&ctl, _("%s: trying to eject using SCSI commands"), ctl.device);
+		worked = eject_scsi(&ctl);
+		verbose(&ctl, worked ? _("SCSI eject succeeded") :
 				 _("SCSI eject failed"));
 	}
 
-	if (f_option && !worked) {
-		verbose(_("%s: trying to eject using floppy eject command"), device);
-		worked = eject_floppy(fd);
-		verbose(worked ? _("floppy eject command succeeded") :
+	if (ctl.f_option && !worked) {
+		verbose(&ctl, _("%s: trying to eject using floppy eject command"), ctl.device);
+		worked = eject_floppy(ctl.fd);
+		verbose(&ctl, worked ? _("floppy eject command succeeded") :
 				 _("floppy eject command failed"));
 	}
 
-	if (q_option && !worked) {
-		verbose(_("%s: trying to eject using tape offline command"), device);
-		worked = eject_tape(fd);
-		verbose(worked ? _("tape offline command succeeded") :
+	if (ctl.q_option && !worked) {
+		verbose(&ctl, _("%s: trying to eject using tape offline command"), ctl.device);
+		worked = eject_tape(ctl.fd);
+		verbose(&ctl, worked ? _("tape offline command succeeded") :
 				 _("tape offline command failed"));
 	}
 
@@ -1144,11 +1146,11 @@ int main(int argc, char **argv)
 		errx(EXIT_FAILURE, _("unable to eject"));
 
 	/* cleanup */
-	close(fd);
-	free(device);
+	close(ctl.fd);
+	free(ctl.device);
 	free(mountpoint);
 
-	mnt_unref_table(mtab);
+	mnt_unref_table(ctl.mtab);
 
 	return EXIT_SUCCESS;
 }
-- 
2.1.0

