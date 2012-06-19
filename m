Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37169 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab2FSMrE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Jun 2012 08:47:04 -0400
Received: by bkcji2 with SMTP id ji2so5035771bkc.19
        for <util-linux@vger.kernel.org>; Tue, 19 Jun 2012 05:47:02 -0700 (PDT)
From: Marek Otahal <markotahal@gmail.com>
To: util-linux@vger.kernel.org
Subject: Clang analysis warnings WAS: Re: dev.c : Warning - dereference of null pointer, clang --analyze
Date: Tue, 19 Jun 2012 14:46:53 +0200
Message-ID: <5021496.29gTT1mHgK@beruska>
In-Reply-To: <1468557.if6BRfJlxj@beruska>
References: <1468557.if6BRfJlxj@beruska>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Clang/llvm analysis on recent git master, hope some of them are relevant (not all mistakes by clang). 

There're memleaks, null pointers passed, uninitialized params passed, execution with unknow priviledges(!), 
null pointere dereference, buffer overflow, etc.

Sorry, the list is quite long, but please take time to skim it all, i didnt sort the warnings by importance, just as they appeared. 



git pull
./autogen.sh
./configure CC="clang" LD="llvm-ld"
make CC="clang -c -O2 --analyze" 

 
 CC       dev.lo
dev.c:91:16: warning: Access to field 'next' results in a dereference of a null pointer
      (loaded from variable 'p')
        list_for_each(p, &dev->bid_tags) {
        ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
../../include/list.h:179:48: note: expanded from macro 'list_for_each'
        for (pos = (head)->next; pos != (head); pos = pos->next)
                                                      ^
1 warning generated.



  CC       canonicalize.lo
../../lib/canonicalize.c:59:15: warning: The left operand of '!=' is a garbage value
        while (*path != '\0') {
               ~~~~~ ^
1 warning generated.



  CC       sysfs.lo
../../lib/sysfs.c:227:9: warning: Null pointer passed as an argument to a 'nonnull' parameter
        return readlink(cxt->dir_path, buf, bufsiz);
               ^        ~~~~~~~~~~~~~
1 warning generated.


  CC       context.lo
context.c:382:38: warning: Access to field 'pid' results in a dereference of a null pointer
      (loaded from variable 'cxt')
        return !mnt_context_is_fork(cxt) && cxt->pid;
                               



  CC       optstr.lo
optstr.c:321:17: warning: Null pointer passed as an argument to a 'nonnull' parameter
        size_t possz = strlen(pos);
                       ^      ~~~



  CC       tab.lo
tab.c:346:3: warning: Access to field 'next' results in a dereference of a null pointer (loaded from field 'p')
                MNT_ITER_ITERATE(itr, *fs, struct libmnt_fs, ents);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./mountP.h:179:5: note: expanded from macro 'MNT_ITER_ITERATE'
                                (itr)->p->next : (itr)->p->prev; \
                                ^      ~



  CC       utils.lo
utils.c:407:24: warning: Branch condition evaluates to a garbage value
        for (p = filesystems; *p; p++)
                              ^~





  CC       loopdev.lo
clang: warning: unknown warning option '-Wmissing-parameter-type'; did you mean '-Wmissing-prototypes'?
clang: warning: unknown warning option '-Wunused-but-set-parameter'; did you mean '-Wunused-parameter'?
clang: warning: unknown warning option '-Wunused-but-set-variable'; did you mean '-Wunused-variable'?
../../lib/loopdev.c:775:2: warning: Access to field 'debug' results in a dereference of a null pointer
      (loaded from variable 'lc')
        DBG(lc, loopdev_debug("get_crypt_name failed"));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../lib/loopdev.c:48:9: note: expanded from macro 'DBG'
                                if ((l)->debug) {\
                                    ^
../../lib/loopdev.c:756:2: warning: Access to field 'debug' results in a dereference of a null pointer
      (loaded from variable 'lc')
        DBG(lc, loopdev_debug("get_encrypt_type [rc=%d]", rc));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../lib/loopdev.c:48:9: note: expanded from macro 'DBG'
                                if ((l)->debug) {\
                                    ^
../../lib/loopdev.c:725:12: warning: Access to field 'flags' results in a dereference of a null pointer
      (loaded from variable 'lc')
        if (rc && loopcxt_ioctl_enabled(lc)) {
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
../../lib/loopdev.c:71:39: note: expanded from macro 'loopcxt_ioctl_enabled'
#define loopcxt_ioctl_enabled(_lc)      (!((_lc)->flags & LOOPDEV_FL_NOIOCTL))
                                           ^
../../lib/loopdev.c:911:6: warning: Access to field 'flags' results in a dereference of a null pointer
      (loaded from variable 'lc')
        if (loopcxt_ioctl_enabled(lc)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~
../../lib/loopdev.c:71:39: note: expanded from macro 'loopcxt_ioctl_enabled'
#define loopcxt_ioctl_enabled(_lc)      (!((_lc)->flags & LOOPDEV_FL_NOIOCTL))
                                           ^
4 warnings generated.



  CC       mkfs.o
mkfs.c:126:40: warning: Memory is never released; potential leak of memory pointed to by 'newpath'
        progname = xmalloc(sizeof(PROGNAME) + strlen(fstype) + 1);
                                              ^~~~~~~~~~~~~~



  CC       fsck-fsck.o
fsck.c:715:3: warning: Function call argument is an uninitialized value
                warnx(_("%s %s: status is %x, should never happen."),
                ^
1 warning generated.
  CCLD     fsck



  CC       mkfs.cramfs.o
mkfs.cramfs.c:863:59: warning: Memory is never released; potential leak of memory pointed to by 'e'
        crc = crc32(crc, (unsigned char *) (rom_image+opt_pad), (offset-opt_pad));
                                                                 ^~~~~~


  CC       fdisk-fdisk.o
fdisk.c:1523:22: warning: The left operand of '<' is a garbage value
                        else if (first[i] < extended_offset ||
                                 ~~~~~~~~ ^
fdisk.c:1491:32: warning: The right operand of '<' is a garbage value
                        if (get_partition_start(pe) < first[i])
                                                    ^ ~~~~~~~~
2 warnings generated.



  CC       fdisk-fdisksunlabel.o
fdisksunlabel.c:316:10: warning: Branch condition evaluates to a garbage value
            if (lens[i]) {
                ^~~~~~~


 CC       fdisk-mbsalign.o
../lib/mbsalign.c:257:14: warning: Value stored to 'start_spaces' during its initialization is never read
      size_t start_spaces = n_spaces / 2 + n_spaces % 2;
             ^              ~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/mbsalign.c:258:14: warning: Value stored to 'end_spaces' during its initialization is never read
      size_t end_spaces = n_spaces / 2;
             ^            ~~~~~~~~~~~~
2 warnings generated.



  CC       sfdisk.o
sfdisk.c:1529:9: warning: Value stored to 'pno' during its initialization is never read
    int pno = z->partno;
        ^     ~~~~~~~~~


CC       cfdisk-cfdisk.o
cfdisk.c:562:7: warning: Null pointer passed as an argument to a 'nonnull' parameter
         if (strlen(str) > (size_t) COLS)
             ^      ~~~



  CC       getopt.o
getopt.c:189:5: warning: Function call argument is an uninitialized value
                                printf(" --%s", longopts[longindex].name);
                                ^               ~~~~~~~~~~~~~~~~~~~~~~~~
getopt.c:456:2: warning: Memory is never released; potential leak of memory pointed to by 'optstr'
        return generate_output(argv + optind - 1, argc-optind + 1,
        ^


  CC       fileutils.o
fileutils.c:78:2: warning: Null pointer passed as an argument to a 'nonnull' parameter
        unlink(tmpname);
        ^      ~~~~~~~



  CC       mangle.o
mangle.c:160:9: warning: Memory is never released; potential leak of memory pointed to by 'ss'
        return EXIT_SUCCESS;
               ^~~~~~~~~~~~
/usr/include/stdlib.h:135:22: note: expanded from macro 'EXIT_SUCCESS'
#define EXIT_SUCCESS    0       /* Successful exit status.  */
                        ^



  CC       pager.o
pager.c:140:2: warning: The left expression of the compound assignment is an uninitialized value. The computed
      value will also be garbage
        FD_SET(0, &in);
        ^~~~~~~~~~~~~~
/usr/include/sys/select.h:91:28: note: expanded from macro 'FD_SET'
#define FD_SET(fd, fdsetp)      __FD_SET (fd, fdsetp)
                                ^
/usr/include/bits/select.h:51:43: note: expanded from macro '__FD_SET'
  ((void) (__FDS_BITS (set)[__FD_ELT (d)] |= __FD_MASK (d)))
                                          ^


  CC       randutils.o
randutils.c:89:9: warning: The left expression of the compound assignment is an uninitialized value. The
      computed value will also be garbage
                *cp++ ^= (rand() >> 7) & 0xFF;
                ~~~~~ ^



  CC       tt.o
tt.c:634:2: warning: Access to field 'next' results in a dereference of a null pointer
        list_for_each(p, &ln->table->tb_columns) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../include/list.h:179:13: note: expanded from macro 'list_for_each'
        for (pos = (head)->next; pos != (head); pos = pos->next)
                   ^~~~~~~~~~~~
../include/list.h:94:13: warning: Access to field 'prev' results in a dereference of a null pointer
      (loaded from variable 'next')
        next->prev = prev;
        ~~~~       ^
tt.c:659:3: warning: Null pointer argument in call to string copy function
                strncpy(buf, cl->name, bufsz);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/usr/include/bits/string2.h:761:33: note: expanded from macro 'strncpy'
#  define strncpy(dest, src, n) __builtin_strncpy (dest, src, n)
                                ^
3 warnings generated.





  CC       loopdev.o
../lib/loopdev.c:911:6: warning: Access to field 'flags' results in a dereference of a null pointer
      (loaded from variable 'lc')
        if (loopcxt_ioctl_enabled(lc)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~
../lib/loopdev.c:71:39: note: expanded from macro 'loopcxt_ioctl_enabled'
#define loopcxt_ioctl_enabled(_lc)      (!((_lc)->flags & LOOPDEV_FL_NOIOCTL))
                                           ^
../lib/loopdev.c:725:12: warning: Access to field 'flags' results in a dereference of a null pointer
      (loaded from variable 'lc')
        if (rc && loopcxt_ioctl_enabled(lc)) {
                  ^~~~~~~~~~~~~~~~~~~~~~~~~
../lib/loopdev.c:71:39: note: expanded from macro 'loopcxt_ioctl_enabled'
#define loopcxt_ioctl_enabled(_lc)      (!((_lc)->flags & LOOPDEV_FL_NOIOCTL))
                                           ^
../lib/loopdev.c:756:2: warning: Access to field 'debug' results in a dereference of a null pointer
      (loaded from variable 'lc')
        DBG(lc, loopdev_debug("get_encrypt_type [rc=%d]", rc));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/loopdev.c:48:9: note: expanded from macro 'DBG'
                                if ((l)->debug) {\
                                    ^
../lib/loopdev.c:775:2: warning: Access to field 'debug' results in a dereference of a null pointer
      (loaded from variable 'lc')
        DBG(lc, loopdev_debug("get_crypt_name failed"));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/loopdev.c:48:9: note: expanded from macro 'DBG'
                                if ((l)->debug) {\
                                    ^
../lib/loopdev.c:815:2: warning: Access to field 'debug' results in a dereference of a null pointer
      (loaded from variable 'lc')
        DBG(lc, loopdev_debug("get_backing_inode [rc=%d]", rc));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/loopdev.c:48:9: note: expanded from macro 'DBG'
                                if ((l)->debug) {\
                                    ^
../lib/loopdev.c:795:2: warning: Access to field 'debug' results in a dereference of a null pointer
      (loaded from variable 'lc')
        DBG(lc, loopdev_debug("get_backing_devno [rc=%d]", rc));
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../lib/loopdev.c:48:9: note: expanded from macro 'DBG'
                                if ((l)->debug) {\
                                    ^
6 warnings generated.




 CC       test_loopdev-sysfs.o
sysfs.c:227:9: warning: Null pointer passed as an argument to a 'nonnull' parameter
        return readlink(cxt->dir_path, buf, bufsiz);
               ^        ~~~~~~~~~~~~~
1 warning generated.




CC       login.o
login.c:1023:4: warning: The return value from the call to 'setregid' is not checked. If an error occurs in
      'setregid', the following code may execute with unexpected privileges
                        setregid(-1, egid);
                        ^~~~~~~~
login.c:1019:4: warning: The return value from the call to 'setreuid' is not checked. If an error occurs in
      'setreuid', the following code may execute with unexpected privileges
                        setreuid(0, pwd->pw_uid);
                        ^~~~~~~~
login.c:1021:4: warning: The return value from the call to 'setuid' is not checked. If an error occurs in
      'setuid', the following code may execute with unexpected privileges
                        setuid(0);      /* setreuid doesn't do it alone! */
                        ^~~~~~
login.c:1018:4: warning: The return value from the call to 'setregid' is not checked. If an error occurs in
      'setregid', the following code may execute with unexpected privileges
                        setregid(-1, pwd->pw_gid);
                        ^~~~~~~~
login.c:1022:4: warning: The return value from the call to 'setreuid' is not checked. If an error occurs in
      'setreuid', the following code may execute with unexpected privileges
                        setreuid(ruid, 0);
                        ^~~~~~~~
login.c:1288:2: warning: Value stored to 'argc' is never read
        argc -= optind;
        ^       ~~~~~~
login.c:1153:2: warning: Null pointer passed as an argument to a 'nonnull' parameter
        setenv("USER", pwd->pw_name, 1);
        ^              ~~~~~~~~~~~~
login.c:1333:8: warning: Memory is never released; potential leak of memory pointed to by 'pwdbuf'
        pwd = cxt.pwd;
              ^~~
login.c:758:5: warning: Memory is never released; potential leak of memory pointed to by 'prompt'
        rc = pam_set_item(pamh, PAM_USER_PROMPT, loginpam_get_prompt(cxt));
        ~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
9 warnings generated.



 CC       sulogin.o
sulogin.c:117:2: warning: Size argument is greater than the length of the destination buffer
        strncpy(id, pass, off);
        ^~~~~~~~~~~~~~~~~~~~~~
/usr/include/bits/string2.h:761:33: note: expanded from macro 'strncpy'
#  define strncpy(dest, src, n) __builtin_strncpy (dest, src, n)
                                ^



  CC       lsblk-lsblk.o
lsblk.c:1335:2: warning: Address of stack memory associated with local variable '_ls' is still referred to by
      the global variable 'lsblk' upon returning to the caller. This will be a dangling reference
        return status;
        ^


 CC       wipefs-wipefs.o
wipefs.c:314:22: warning: Access to field 'zap' results in a dereference of a null pointer
      (loaded from variable 'wp')
        int zap = all ? 1 : wp->zap;
                            ^~



  CC       namei.o
namei.c:392:5: warning: Access to field 'name' results in a dereference of a null pointer
                                get_id(ucache, nm->st.st_uid)->name);
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



  CC       lslocks.o
In file included from lslocks.c:38:
In file included from ../include/tt.h:12:
../include/list.h:94:13: warning: Access to field 'prev' results in a dereference of a null pointer
      (loaded from variable 'next')
        next->prev = prev;
        ~~~~       ^




 CC       rename.o
rename.c:47:8: warning: Dereference of null pointer
                *q++ = *p++;
                ~~~~~^~~~~~
rename.c:44:8: warning: Dereference of null pointer
                *q++ = *p++;
                ~~~~~^~~~~~
rename.c:50:8: warning: Dereference of null pointer
                *q++ = *p++;
                ~~~~~^~~~~~
3 warnings generated.



  CC       dmesg.o
dmesg.c:790:2: warning: Value stored to 'argv' is never read
        argv += optind;
        ^       ~~~~~~
dmesg.c:791:2: warning: Value stored to 'n' is never read
        n = 0;
        ^   ~


sending this part, as it's getting long...
-mark

-- 

Marek Otahal :o)
