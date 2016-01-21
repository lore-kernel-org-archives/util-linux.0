Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
To: Karel Zak <kzak@redhat.com>
References: <569FEF38.9010102@suse.cz> <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz> <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A0F847.5000000@suse.cz> <20160121153713.erxzeieqtnsf2wsu@ws.net.home>
 <20160121154529.hpv3ycl2syptemp4@ws.net.home>
Cc: util-linux@vger.kernel.org,
        =?UTF-8?B?RGF2aWQgxaB0xJtyYmE=?=
 <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56A1146B.7010707@suse.cz>
Date: Thu, 21 Jan 2016 18:24:59 +0100
MIME-Version: 1.0
In-Reply-To: <20160121154529.hpv3ycl2syptemp4@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, Jan 21, 2016 at 04:37:13PM +0100, Karel Zak wrote:
>>> David also wrote btrfs_get_default_subvolume_path(), but then we found,
>>> that there is probably better to use subvolid and path saved in
>>> procinfo:
>>
>> Do you mean /proc/self/mountinfo ?
Yes.

> Read it and the patch again, and now it makes sense. Yes, the ioctl and
> subvolid= from mountinfo seems better than dependence on libbtrfs.

Well, the function btrfs_get_default_subvolume_path() does not exist in
libbtrfs.

Our first implementation did not use subvolid search in mountinfo and
constructed the default path by using BACKREF chain evaluation using
btrfs specific ioctl().

The required tab.c change was then very small:
 		if (mnt_fs_get_option(fs, "subvol", &vol, &volsz))
-			goto dflt;
+		{
+			vol = btrfs_get_default_subvolume_path(mnt_fs_get_target(fs));
+			if (!vol)
+				goto dflt;
+			volsz = strlen(vol);
+		} else

But btrfs_get_default_subvolume_path() was complicated. It has to been
written from scratch, as btfs-progs read the whole subvolume table to
memory and performs evaluation in the memory. It is something we really
don't want on system with thousands snapshots.

The patch I sent uses ioctl() to get subvolid, and the rest is found in
mountinfo. It looks better to me.

If somebody is interested in the function that went to the trash, here
it is. Maybe it could be useful for somebody else.

static inline bool prepend_path(char subvol_buffer[PATH_MAX], int *subvol_buffer_index, char *name, int namelen)
{
	if (namelen == 0)
		return true;
	while (name[namelen - 1] == '/') {
		namelen--;
		if (namelen == 0)
			return true;
	}
	/* PATH_MAX - 1 could be fatal here, but it would fail elsewhere anyway. */
	if (*subvol_buffer_index < namelen + 1) {
		printf("PATH_MAX exceeded\n");
		return false;
	}
	/* Is not it the last item? */
	if (*subvol_buffer_index != PATH_MAX - 1) {
		subvol_buffer[*subvol_buffer_index - 1] = '/';
		(*subvol_buffer_index)--;
	}
	*subvol_buffer_index -= namelen;
	memcpy(&subvol_buffer[*subvol_buffer_index], name, namelen);
	return true;
}
	
/**
 * btrfs_get_default_subvolume_path:
 * @path: Path to mounted btrfs volume
 *
 * Evaluates btrfs tree and returns path to the default subvolume
 * relative to the volume root.
 *
 * Returns: default subvolume path or NULL in case of no default
 * subvolume or error. In case of error, errno is set properly.
 */
char *btrfs_get_default_subvolume_path(const char *path)
{
	int iocret;
	int fd = -1;
	DIR *dirstream = NULL;
	struct btrfs_ioctl_search_args args;
	struct btrfs_ioctl_search_key *sk = &args.key;
	struct btrfs_ioctl_search_header *sh;
	u64 found = 0;
	u64 parent = 0;
	u64 dirid = 0;
	struct btrfs_ioctl_ino_lookup_args lookup_args;
	struct btrfs_root_ref *root_ref;
	char subvol_path[PATH_MAX];
	int subvol_path_index = PATH_MAX-1;
	int namelen;
	char *ret_path = NULL;

	errno = 0;

	subvol_path[PATH_MAX - 1] = 0;

	fd = btrfs_open_dir(path, &dirstream, 1);
	if (fd < 0) {
		printf("ERROR: open\n");
		goto out;
	}
	memset(&args, 0, sizeof(args));

	sk->tree_id = BTRFS_ROOT_TREE_OBJECTID;
	sk->min_objectid = BTRFS_ROOT_TREE_DIR_OBJECTID;
	sk->max_objectid = BTRFS_ROOT_TREE_DIR_OBJECTID;
	sk->min_type = BTRFS_DIR_ITEM_KEY;
	sk->max_type = BTRFS_DIR_ITEM_KEY;
	sk->max_offset = (u64)-1;
	sk->max_transid = (u64)-1;
	sk->nr_items = 1;

	iocret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
	if (iocret < 0) {
		DBG(BTRFS, ul_debug("ioctl() failed for \"%s\" [errno=%d %m]", path, errno));
		goto out;
	}

	/* the ioctl returns the number of items it found in nr_items */
	if (sk->nr_items == 0) {
		DBG(BTRFS, ul_debug("root tree dir object id not found"));
		goto out;
	}
	DBG(BTRFS, ul_debug("found %d root tree dir object id items", sk->nr_items));

	sh = (struct btrfs_ioctl_search_header *)args.buf;

	if (sh->type == BTRFS_DIR_ITEM_KEY) {
		struct btrfs_dir_item *di;
		int name_len;
		char *name;

		di = (struct btrfs_dir_item *)(sh + 1);
		name_len = btrfs_stack_dir_name_len(di);
		name = (char *)(di + 1);

		if (!strncmp("default", name, name_len)) {
			found = btrfs_disk_key_objectid(&di->location);
			DBG(BTRFS, ul_debug("\"default\" id is %llu", (unsigned long long)found));
		} else {
			DBG(BTRFS, ul_debug("\"default\" id not found in tree root"));
			goto out;
		}
	} else {
		DBG(BTRFS, ul_debug("unexpected type found: %d", (int)sh->type));
		goto out;
	}

next_level:
	/* look up parent */
	DBG(BTRFS, ul_debug("lookup BACKREFs for %llu", (unsigned long long)found));
	memset(&args, 0, sizeof(args));

	sk->tree_id = BTRFS_ROOT_TREE_OBJECTID;
	sk->min_objectid = found;
	sk->max_objectid = found;
	sk->min_type = BTRFS_ROOT_BACKREF_KEY;
	sk->max_type = BTRFS_ROOT_BACKREF_KEY;
	sk->min_offset = 0;
	sk->max_offset = (u64)-1;
	sk->max_transid = (u64)-1;
	sk->nr_items = 4096;

	iocret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
	if (iocret < 0) {
		DBG(BTRFS, ul_debug("ioctl() failed [errno=%d %m]", errno));
		goto out;
	}

	/* the ioctl returns the number of items it found in nr_items */
	if (sk->nr_items == 0) {
		DBG(BTRFS, ul_debug("BACKREF not found"));
		goto out;
	}

	sh = (struct btrfs_ioctl_search_header *)args.buf;

	if (sh->type == BTRFS_ROOT_BACKREF_KEY) {
		char *name;

		parent = sh->offset;
		root_ref = (struct btrfs_root_ref*)(sh + 1);
		dirid = btrfs_stack_root_ref_dirid(root_ref);
		DBG(BTRFS, ul_debug("BACKREF points to %llu dirid %llu",
				    (unsigned long long)sh->offset,
				    (unsigned long long)dirid));
		namelen = btrfs_stack_root_ref_name_len(root_ref);
		name = (char *)(root_ref + 1);
		DBG(BTRFS, ul_debug("path component: %*s", namelen, name));

		/* The current implementation never adds trailing '/'
		   here. But it is an implementation detail and we
		   should not depend on it. */
		if (!prepend_path(subvol_path, &subvol_path_index, name, namelen)) {
			goto out;
		}
	} else {
		DBG(BTRFS, ul_debug("BACKREF key not found: %d", (int)sh->type));
		goto out;
	}

	memset(&lookup_args, 0, sizeof(lookup_args));
	lookup_args.treeid = parent;
	lookup_args.objectid = dirid;
	DBG(BTRFS, ul_debug("DIRID resolve for %llu", (unsigned long long)dirid));
	iocret = ioctl(fd, BTRFS_IOC_INO_LOOKUP, &lookup_args);
	if (iocret < 0) {
		DBG(BTRFS, ul_debug("DIRID search ioctl() failed %llu [errno=%d %m]", (unsigned long long)dirid, errno));
		goto out;
	}
	DBG(BTRFS, ul_debug("path component: %s", lookup_args.name));
	namelen = strlen(lookup_args.name);
	/* The current implementation always adds trailing '/' here.
	   But it is an implementation detail and we should not depend
	   on it. */
		if (!prepend_path(subvol_path, &subvol_path_index, lookup_args.name, namelen)) {
			goto out;
		}
	if (parent != BTRFS_FS_TREE_OBJECTID) {
		DBG(BTRFS, ul_debug("NOT at the toplevel, looping"));
		found = parent;
		goto next_level;
	}

	close_file_or_dir(fd, dirstream);

	return strdup(&subvol_path[subvol_path_index]);
out:
	return NULL;
}


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
