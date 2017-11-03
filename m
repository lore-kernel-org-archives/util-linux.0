Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753062AbdKCNdx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 3 Nov 2017 09:33:53 -0400
Date: Fri, 3 Nov 2017 14:33:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Ximin Luo <infinity0@pwned.gg>
Cc: util-linux@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Bug: for mount namespaces inside a chroot, unshare works but
 nsenter doesn't
Message-ID: <20171103133348.p4coyse7eoibcpsn@ws.net.home>
References: <7b168fc6-957c-3c98-d7f2-673842ee550c@pwned.gg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <7b168fc6-957c-3c98-d7f2-673842ee550c@pwned.gg>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 27, 2017 at 06:07:00PM +0000, Ximin Luo wrote:
> When unsharing persistent mount namespaces, unshare+nsenter does not seem to
> work properly when run from inside a chroot session. However, unshare by itself
> works.

It's not related to persistent namespace, but to the way how nsenter
uses chroot().

> As a workaround for the unshare+nsenter case, one can run `nsenter --mount=<ns>
> chroot <real/path/to/chroot> command args`. The `--root` option to `nsenter`
> sounds like it should work, but it does not - see below for details.
> 
> Is this a bug? 

It seems like nsenter logic problem.

The command nsenter opens root-dir and cwd file descriptors *before*
setns() syscall, and than *after* the syscall it calls chroot(). The
final process is in the namespace, but no in the root directory.

        open("/mnt/test/chroot/namespaces/mnt", O_RDONLY) = 3
        open("/mnt/test/chroot", O_RDONLY)      = 4
        open("/mnt/test/chroot", O_RDONLY)      = 5
        setns(3, CLONE_NEWNS)                   = 0
        close(3)                                = 0
        fchdir(4)                               = 0
        chroot(".")                             = 0
        close(4)                                = 0
        fchdir(5)                               = 0
        close(5)                                = 0
        execve("/bin/bash", ["-bash"], 0x7ffd2b5244d0 /* 31 vars */) = 0

The patch below fixes the issue. It just moves root-dir and cwd open
calls *after* the setns():

        open("/mnt/test/chroot/namespaces/mnt", O_RDONLY) = 3
        setns(3, CLONE_NEWNS)                   = 0
        close(3)                                = 0
        open("/mnt/test/chroot", O_RDONLY)      = 3
        open("/mnt/test/chroot", O_RDONLY)      = 4
        fchdir(4)                               = 0
        chroot(".")                             = 0
        close(4)                                = 0
        fchdir(3)                               = 0
        close(3)                                = 0
        execve("/bin/bash", ["-bash"], 0x7fff1ff8eb60 /* 31 vars */) = 0

Unfortunately, I'm not sure if this is the right way in all cases. 

Eric?


Examples:

*** I have simple chroot directory:

        ls -la /mnt/test/chroot
        total 20
        drwxr-xr-x    5 root root 4096 Nov  3 13:10 .
        drwxr-xr-x.   8 root root 4096 Nov  2 15:36 ..
        lrwxrwxrwx    1 root root    8 Nov  2 15:40 bin -> /usr/bin
        lrwxrwxrwx    1 root root    8 Nov  2 15:40 lib -> /usr/lib
        lrwxrwxrwx    1 root root   10 Nov  2 15:40 lib64 -> /usr/lib64
        drwxr-xr-x    4 root root 4096 Nov  3 13:22 namespaces
        dr-xr-xr-x  330 root root    0 Sep 26 22:17 proc
        lrwxrwxrwx    1 root root    9 Nov  2 15:40 sbin -> /usr/sbin
        drwxr-xr-x.  14 root root 4096 Aug 16 10:50 usr

where is bind mounted /usr and mounted /proc

        # findmnt -oTARGET,SOURCE,FSTYPE,PROPAGATION --submounts /mnt/test/chroot
        TARGET                  SOURCE                      FSTYPE PROPAGATION
        /mnt/test/chroot        /dev/sda4[/mnt/test/chroot] ext4   private
        ├─/mnt/test/chroot/usr  /dev/sda4[/usr]             ext4   shared
        └─/mnt/test/chroot/proc proc                        proc   private

let's enter the root and create persistent mount namespace within the chroot:

        # chroot /mnt/test/chroot
        # unshare --mount=namespaces/mnt

our mount table:

        findmnt -oTARGET,SOURCE,FSTYPE,PROPAGATION
        TARGET  SOURCE                      FSTYPE PROPAGATION
        /       /dev/sda4[/mnt/test/chroot] ext4   private
        ├─/usr  /dev/sda4[/usr]             ext4   private
        └─/proc proc                        proc   private

and our mount namespace:

        # ls -la /proc/self/ns | grep mnt
        lrwxrwxrwx 1 0 0 0 Nov  3 12:56 mnt -> mnt:[4026532457]

our pid:

        # echo $$
        14411

IMHO good idea is keep the shell alive in the chroot and use another session 
to play with nsenter.

*** nsenter examples:

a) let's try it by PID, all works as expected:

        # nsenter --target 14411 --mount --root --wd

        # findmnt -oTARGET,SOURCE,FSTYPE,PROPAGATION
        TARGET  SOURCE                      FSTYPE PROPAGATION
        /       /dev/sda4[/mnt/test/chroot] ext4   private
        ├─/usr  /dev/sda4[/usr]             ext4   private
        └─/proc proc                        proc   private

        # ls -la /proc/self/ns | grep mnt
        lrwxrwxrwx 1 0 0 0 Nov  3 13:02 mnt -> mnt:[4026532457]

   Important note: in this case nsenter uses /proc/<target>/root for
   chroot(), but the goal is to use persistent namespace where no <target>
   available.

b) let's try chroot() by path:

        # nsenter --target 14411 --mount --root=/mnt/test/chroot --wd=/mnt/test/chroot

        # findmnt -oTARGET,SOURCE,FSTYPE,PROPAGATION

   failed, mount table is empty

c) let's try chroot by /proc paths:

        # nsenter --target 14411 --mount --root=/mnt/test/chroot/proc/14411/root --wd=/mnt/test/chroot/proc/14411/cwd

        # findmnt -oTARGET,SOURCE,FSTYPE,PROPAGATION
        TARGET  SOURCE                      FSTYPE PROPAGATION
        /       /dev/sda4[/mnt/test/chroot] ext4   private
        ├─/usr  /dev/sda4[/usr]             ext4   private
        └─/proc proc                        proc   private

        # ls -la /proc/self/ns | grep mnt
        lrwxrwxrwx 1 0 0 0 Nov  3 13:09 mnt -> mnt:[4026532457]

   it works!


Note that --target or --mount=<persistent> namespace does not change
anything here.

The nsenter with the patch:


        # ./nsenter --mount=/mnt/test/chroot/namespaces/mnt  --root=/mnt/test/chroot --wd=/mnt/test/chroot

        # findmnt -oTARGET,SOURCE,FSTYPE,PROPAGATION
        TARGET  SOURCE                      FSTYPE PROPAGATION
        /       /dev/sda4[/mnt/test/chroot] ext4   private
        ├─/usr  /dev/sda4[/usr]             ext4   private
        └─/proc proc                        proc   private

        # ls -la /proc/self/ns | grep mnt
        lrwxrwxrwx 1 0 0 0 Nov  3 13:11 mnt -> mnt:[4026532457]

all works as expected. The patch is below.

    Karel


diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 9c452c1d1..464f9f98c 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -238,6 +238,7 @@ int main(int argc, char *argv[])
 	int do_fork = -1; /* unknown yet */
 	uid_t uid = 0;
 	gid_t gid = 0;
+	const char *rd_path = NULL, *wd_path = NULL;
 #ifdef HAVE_LIBSELINUX
 	bool selinux = 0;
 #endif
@@ -318,13 +319,13 @@ int main(int argc, char *argv[])
 			break;
 		case 'r':
 			if (optarg)
-				open_target_fd(&root_fd, "root", optarg);
+				rd_path = optarg;
 			else
 				do_rd = true;
 			break;
 		case 'w':
 			if (optarg)
-				open_target_fd(&wd_fd, "cwd", optarg);
+				wd_path = optarg;
 			else
 				do_wd = true;
 			break;
@@ -433,6 +434,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (wd_path)
+		open_target_fd(&wd_fd, "cwd", wd_path);
+	if (rd_path)
+		open_target_fd(&root_fd, "root", rd_path);
+
 	/* Remember the current working directory if I'm not changing it */
 	if (root_fd >= 0 && wd_fd < 0) {
 		wd_fd = open(".", O_RDONLY);

    


> I'm trying to write code to work regardless of whether it's run
> inside a chroot, so it would be nice not to have to pass arguments to
> `nsenter(1)` that are specific to chroots, like `chroot <real/path/to/chroot>`.
> It's also a bit counterintuitive to have to re-enter the chroot again.
> 
> Also, these extra steps are not needed with `unshare(1)`, which works fine by
> itself. It's solely re-entering the namespace that seems to be problematic.
> 
> I'm using util-linux 2.30.2-0.1 on Debian. I don't believe it's a problem
> specific to Debian, because everything works when using `unshare(1)` by itself,
> as stated.
> 
> (I haven't tried running this inside a chroot-inside-a-chroot.)
> 
> Details:
> 
> # Below is all run inside a "schroot" session, which is a Debian tool for making chroot use more convenient.
> # I used the instructions here (https://wiki.debian.org/sbuild#Create_the_chroot) to create one.
> 
> ## Preparation for the tests
> 
> # Enter the chroot
> $ sudo schroot -c unstable-amd64-sbuild
> # Set up a private-bind file to hold a handle to our new namespace, as documented in the man page of unshare(1)
> (unstable-amd64-sbuild)root@localhost:/tmp# touch ns-mnt; mount --bind --make-private ns-mnt ns-mnt
> # Set up our test script
> (unstable-amd64-sbuild)root@localhost:/tmp# script='mount; ls /; ls -l /proc/$$/ns/mnt; mount -B /dev/null /etc/hosts; echo hosts:; cat /etc/hosts'
> 
> ## Case 1: unshare(1) with no special options or commands, everything works as expected
> 
> (unstable-amd64-sbuild)root@localhost:/tmp# unshare --mount=ns-mnt sh -ec "$script"
> unstable-amd64-sbuild on / type overlay (rw,relatime,lowerdir=/var/lib/schroot/union/underlay/<<SESSIONID>>,...)
> proc on /proc type proc (rw,relatime)
> sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
> [.. etc. other mappings in my chroot ..]
> unstable-amd64-sbuild on /tmp/ns-mnt type overlay (rw,relatime,lowerdir=/var/lib/schroot/union/underlay/<<SESSIONID>>,...)
> bin  boot  build  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run	sbin  srv  sys	tmp  usr  var
> lrwxrwxrwx 1 root root 0 Oct 27 17:35 /proc/31691/ns/mnt -> 'mnt:[4026532398]'
> hosts:
> [.. empty hosts (inside the namespace) ..]
> # we are now back outside the namespace
> # if we cat /etc/hosts (both inside and outside the chroot), we see the original
> 
> ## now we try to re-enter the namespace.
> 
> ## Case 2: nsenter(1) with no extra options or commands, doesn't work:
> 
> (unstable-amd64-sbuild)root@localhost:/tmp# nsenter --mount=ns-mnt sh -ec "$script"
> [.. mappings for my host system, outside the chroot ..]
> bin  boot  dev	etc  home  initrd.img  initrd.img.old  lib  lib32  lib64  libx32  lost+found  media  mnt  opt  proc  root  run	sbin  selinux  srv  sys  tmp  usr  var	vmlinuz  vmlinuz.old
> [.. aka the / on my host filesystem outside the chroot ..]
> lrwxrwxrwx 1 root root 0 Oct 27 19:36 /proc/32434/ns/mnt -> 'mnt:[4026532398]'
> [.. correct namespace ..]
> hosts:
> [.. empty hosts (inside the namespace) ..]
> # if we cat /etc/hosts outside the namespace, it's non-empty inside the chroot but EMPTY outside the chroot.
> # whoops, because we ran mount -B on the original non-chrooted / filesystem. findmnt says:
> └─/etc/hosts                          udev[/null]                        devtmpfs    rw,nosuid,relatime,size=8181852k,nr_inodes=2045463,mode=755
> # we unmount it before proceeding
> 
> ## Case 3: nsenter(1) with --root, partially works but not really:
> 
> (unstable-amd64-sbuild)root@localhost:/tmp# nsenter --root=/ --mount=ns-mnt sh -ec "$script"
> [.. i.e. mount(1) gives empty output ..]
> bin  boot  build  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run	sbin  srv  sys	tmp  usr  var
> [.. at least the root is inside the chroot ..]
> lrwxrwxrwx 1 root root 0 Oct 27 17:37 /proc/878/ns/mnt -> 'mnt:[4026532398]'
> [.. correct namespace ..]
> mount: /etc/hosts: wrong fs type, bad option, bad superblock on /dev/null, missing codepage or helper program, or other error.
> [.. mount operations fail, but the namespace is correct ..]
> [.. if you analyse this case a bit more, you find that /proc/$$/{mounts,mountinfo,mountstats} are all empty ..]
> # exit code 32
> # outside the namespace, /etc/hosts is still non-empty, both inside and outside the chroot
> 
> ## Case 4: nsenter(1) with explicit chroot(1) call, everything works as expected, again:
> 
> (unstable-amd64-sbuild)root@localhost:/tmp# nsenter --mount=ns-mnt chroot /run/schroot/mount/<<SESSIONID>> sh -ec 'mount && ls /'
> unstable-amd64-sbuild on / type overlay (rw,relatime,lowerdir=/var/lib/schroot/union/underlay/<<SESSIONID>>,...)
> proc on /proc type proc (rw,relatime)
> sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
> [.. etc. other mappings in my chroot ..]
> unstable-amd64-sbuild on /tmp/ns-mnt type overlay (rw,relatime,lowerdir=/var/lib/schroot/union/underlay/<<SESSIONID>>,...)
> [.. great, we got our mounts back! ..]
> bin  boot  build  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run	sbin  srv  sys	tmp  usr  var
> lrwxrwxrwx 1 root root 0 Oct 27 17:39 /proc/2025/ns/mnt -> 'mnt:[4026532398]'
> [.. correct namespace ..]
> hosts:
> [.. empty hosts, as desired ..]
> # outside the namespace, /etc/hosts is still non-empty, both inside and outside the chroot
> 
> -- 
> GPG: ed25519/56034877E1F87C35
> GPG: rsa4096/1318EFAC5FBBDBCE
> https://github.com/infinity0/pubkeys.git
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
