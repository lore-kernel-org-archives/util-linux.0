Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] tests: add btrfs mount tests (fails!)
To: Karel Zak <kzak@redhat.com>
References: <56B0EEB2.1060707@suse.cz> <56B10E38.7040407@suse.cz>
 <20160211094352.6ncnnirhyd4jjd34@ws.net.home> <56BC9101.60908@suse.cz>
 <56C72E9B.3050402@suse.cz>
Cc: util-linux@vger.kernel.org, David Sterba <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56E075D6.2040704@suse.cz>
Date: Wed, 9 Mar 2016 20:13:26 +0100
MIME-Version: 1.0
In-Reply-To: <56C72E9B.3050402@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

On Feb 19, 2016 at 16:02 Stanislav Brabec wrote:
> On Feb 11 2016 at 14:47 Stanislav Brabec wrote:
>> There are missing umount commands in the middle of the test, which
>> trigger following problem:
>>
>> Additionally, I am working on a reproducer of an invalid "mount -a"
>> behavior triggered by kernel bug reporting false subvol.
> 
>> I already have a possible fix for it, but I want to confirm that it is
>> correct before sending it upstream.
> 
> I finally found a reproducer.
> 
Well, now I have a real reproducer that is not triggered by another bug.

My findings:

1) The way to reproduce is extremely obscure, because not only subvolid
has to match, but also target.

2) There is no way to fix it in an easy way. I suggested a new
algorithm searching for shortest subvol, but it would be vulnerable to
bad evaluation as well.

So I decided to keep the code as it is.

Way to reproduce:

To confuse the algorithm, there has to be a mounted something else into
the target than fstab specifies.

Step 1:
/dev/loop0 /btrfs_mnt_root btrfs subvol=/ 0 0
/btrfs_mnt_root/d0/dd0/ddd0/s1/d1/dd1/ddd1/s2/bind-mnt /btrfs_mnt_bind btrfs bind,private 0 0

It will create following mountinfo:
299 72 0:83 / /btrfs_mnt_root rw,relatime shared:211 - btrfs /dev/loop0 rw,space_cache,subvolid=5,subvol=/
312 72 0:83 /d0/dd0/ddd0/s1/d1/dd1/ddd1/s2/bind-mnt /btrfs_mnt_bind rw,relatime shared:211 - btrfs /dev/loop0 rw,space_cache,subvolid=258,subvol=/d0/dd0/ddd0/s1/d1/dd1/ddd1/s2/bind-mnt

Note that subvolid 258 does not correspond to / nor to
d0/dd0/ddd0/s1/d1/dd1/ddd1/s2/bind-mnt, but it corresponds to
d0/dd0/ddd0/s1/d1/dd1/ddd1/s2.

Now remove both lines from fstab and add:

/dev/loop0 /btrfs_mnt_bind btrfs defaults 0 0

Default subvolume is d0/dd0/ddd0/s1/d1/dd1/ddd1/s2, but the algorithm
(both the existing and the previously suggested one) falsely assumes
that it is /d0/dd0/ddd0/s1/d1/dd1/ddd1/s2/bind-mnt, because both
subvolid and target match.

In theory, the new fstab should cause mounting the default subvolume
over the existing one, but nothing happens.

Summary:

- The full fix would mean evaluation of the btrfs subvolume tree
  structure (several ioctl() with possible need of disk lookups) just
  to find, whether it is already mounted or no.

- The reproducer is really obscure, and nothing from a real life cannot
  trigger it.

- The full fix will be vulnerable to another unfixable problems (e. g.
  when somebody changes the default subvolume path while the device is
  mounted).

=> I propose to keep this part of code with a known bug.



Here is the the previously proposed (obsolete) fix:

---
 libmount/src/tab.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 102ed25..556d835 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1224,6 +1224,18 @@ static char *remove_mountpoint_from_path(const char *path, const char *mnt)
 }
 
 #ifdef HAVE_BTRFS_SUPPORT
+/* All currently existing kernels reports incorrect values for bind
+ * mounts. Instead of subvol/subvolid of a subvolume used for creating of bind
+ * mount, it reports subvolid corresponding to nearest upper subvol node and
+ * subvol pointing to the current dir relative to btrfs root.
+ *
+ * The current kernel btrfs implementation has not access to proper VFS
+ * structures, so it is just guessing. Fixing this will need refactoring of
+ * kernel btrfs subvol implementation. It is not expected to happen anytime
+ * soon. Set this define to suppose that kernels are buggy, and don't blindly
+ * trust to the reported mountinfo values. */
+#define KERNEL_BTRFS_REPORTS_FALSE_SUBVOL 1
+
 static int get_btrfs_fs_root(struct libmnt_table *tb, struct libmnt_fs *fs, char **root)
 {
 	char *vol = NULL, *p;
@@ -1236,6 +1248,12 @@ static int get_btrfs_fs_root(struct libmnt_table *tb, struct libmnt_fs *fs, char
 		char *target;
 		struct libmnt_fs *f;
 		char subvolidstr[sizeof(stringify_value(UINT64_MAX))];
+#ifdef KERNEL_BTRFS_REPORTS_FALSE_SUBVOL
+		struct libmnt_fs *t;
+		struct libmnt_iter itr;
+		char *optval = NULL;
+		size_t optvalsz = 0, valsz, bestvalsz = PATH_MAX;
+#endif
 
 		DBG(BTRFS, ul_debug(" found subvolid=%s, checking", vol));
 
@@ -1248,9 +1266,24 @@ static int get_btrfs_fs_root(struct libmnt_table *tb, struct libmnt_fs *fs, char
 			goto err;
 
 		DBG(BTRFS, ul_debug(" tring target=%s subvolid=%s", target, subvolidstr));
+#ifndef KERNEL_BTRFS_REPORTS_FALSE_SUBVOL
 		f = mnt_table_find_target_with_option(tb, target,
 					"subvolid", subvolidstr,
 					MNT_ITER_BACKWARD);
+#else
+		f = NULL;
+		valsz = strlen(subvolidstr);
+		mnt_reset_iter(&itr, MNT_ITER_BACKWARD);
+		while (mnt_table_next_fs(tb, &itr, &t) == 0) {
+			if (mnt_fs_streq_target(t, target)
+			    && mnt_fs_get_option(t, "subvolid", &optval, &optvalsz) == 0
+			    && optvalsz == valsz
+			    && strncmp(optval, subvolidstr, optvalsz) == 0
+			    && optvalsz < bestvalsz)
+				f = t;
+		}
+#endif
+
 		if (!tb->cache)
 			free(target);
 		if (!f)
@@ -1271,6 +1304,12 @@ static int get_btrfs_fs_root(struct libmnt_table *tb, struct libmnt_fs *fs, char
 		char *target;
 		struct libmnt_fs *f;
 		char default_id_str[sizeof(stringify_value(UINT64_MAX))];
+#ifdef KERNEL_BTRFS_REPORTS_FALSE_SUBVOL
+		struct libmnt_fs *t;
+		struct libmnt_iter itr;
+		char *optval = NULL;
+		size_t optvalsz = 0, valsz, bestvalsz = PATH_MAX;
+#endif
 
 		DBG(BTRFS, ul_debug(" subvolid/subvol not found, checking default"));
 
@@ -1295,9 +1334,24 @@ static int get_btrfs_fs_root(struct libmnt_table *tb, struct libmnt_fs *fs, char
 		DBG(BTRFS, ul_debug(" tring target=%s default subvolid=%s",
 					target, default_id_str));
 
+#ifndef KERNEL_BTRFS_REPORTS_FALSE_SUBVOL
 		f = mnt_table_find_target_with_option(tb, target,
 					"subvolid", default_id_str,
 					MNT_ITER_BACKWARD);
+#else
+		f = NULL;
+		valsz = strlen(default_id_str);
+		mnt_reset_iter(&itr, MNT_ITER_BACKWARD);
+		while (mnt_table_next_fs(tb, &itr, &t) == 0) {
+			if (mnt_fs_streq_target(t, target)
+			    && mnt_fs_get_option(t, "subvolid", &optval, &optvalsz) == 0
+			    && optvalsz == valsz
+			    && strncmp(optval, default_id_str, optvalsz) == 0
+			    && optvalsz < bestvalsz)
+				f = t;
+		}
+#endif
+
 		if (!tb->cache)
 			free(target);
 		if (!f)
-- 
2.7.2

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
