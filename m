Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53059 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab2FSNEx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Jun 2012 09:04:53 -0400
Received: by wgbdr13 with SMTP id dr13so6782757wgb.1
        for <util-linux@vger.kernel.org>; Tue, 19 Jun 2012 06:04:52 -0700 (PDT)
From: Marek Otahal <markotahal@gmail.com>
To: util-linux@vger.kernel.org
Subject: [cont.] Clang analysis warnings WAS: Re: dev.c : Warning - dereference of null pointer, clang --analyze
Date: Tue, 19 Jun 2012 15:04:42 +0200
Message-ID: <2742871.Oj4GcWpr5f@beruska>
In-Reply-To: <5021496.29gTT1mHgK@beruska>
References: <1468557.if6BRfJlxj@beruska> <5021496.29gTT1mHgK@beruska>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 19 of June 2012 14:46:53 you wrote:
> Clang/llvm analysis on recent git master, hope some of them are relevant (not all mistakes by clang). 
> 
> There're memleaks, null pointers passed, uninitialized params passed, execution with unknow priviledges(!), 
> null pointere dereference, buffer overflow, etc.
> 
> Sorry, the list is quite long, but please take time to skim it all, i didnt sort the warnings by importance, just as they appeared. 
> 
 CC       switch_root.o
switch_root.c:213:7: warning: Dereference of null pointer (loaded from variable 'newroot')
        if (!*newroot || !*init)
             ^~~~~~~~



  CC       flock.o
flock.c:281:8: warning: Null pointer passed as an argument to a 'nonnull' parameter
                            access(filename, R_OK | W_OK) == 0) {
                            ^      ~~~~~~~~



  CC       ipcs.o
ipcs.c:476:8: warning: Function call argument is an uninitialized value
                pw = getpwuid(ipcp->uid);
                     ^        ~~~~~~~~~
ipcs.c:246:40: warning: The left operand of '&' is a garbage value
        printf ("%-10d %-10o", id, ipcp->mode & 0777);
                                   ~~~~~~~~~~ ^
ipcs.c:432:3: warning: Function call argument is an uninitialized value
                printf (_("max number of arrays = %d\n"), seminfo.semmni);
                ^                                         ~~~~~~~~~~~~~~
ipcs.c:441:3: warning: Function call argument is an uninitialized value
                printf (_("used arrays = %d\n"), seminfo.semusz);
                ^                                ~~~~~~~~~~~~~~
ipcs.c:688:2: warning: Function call argument is an uninitialized value
        printf (_("uid=%u\t gid=%u\t cuid=%u\t cgid=%u\n"),
        ^
5 warnings generated. 



  CC       cytune.o
cytune.c:202:8: warning: Function call argument is an uninitialized value
                        if (ioctl(cmon[cmon_index].cfile, CYGETMON, &cywork))
                            ^     ~~~~~~~~~~~~~~~~~~~~~~
cytune.c:456:3: warning: Address of stack memory associated with local variable 'argv' is still referred to by
      the global variable 'global_argv' upon returning to the caller. This will be a dangling reference
                return EXIT_SUCCESS;
                ^
cytune.c:460:2: warning: Address of stack memory associated with local variable 'argv' is still referred to by
      the global variable 'global_argv' upon returning to the caller. This will be a dangling reference
        return EXIT_SUCCESS;
        ^
cytune.c:380:4: warning: Address of stack memory associated with local variable 'argv' is still referred to by
      the global variable 'global_argv' upon returning to the caller. This will be a dangling reference
                        return EXIT_SUCCESS;
                        ^
4 warnings generated.




  CC       eject-eject.o
eject.c:619:2: warning: Value stored to 'status' is never read
        status = ioctl(fd, BLKRRPART);
        ^        ~~~~~~~~~~~~~~~~~~~~



 CC       prlimit.o
prlimit.c:364:20: warning: Access to field 'resource' results in a dereference of a null pointer
      (loaded from field 'desc')
                if (prlimit(pid, lim->desc->resource, new, old) == -1)
                                 ^    ~~~~


 CC       lscpu.o
In file included from lscpu.c:38:
../include/xalloc.h:45:21: warning: Call to 'calloc' has an allocation size of 0 bytes
        void *ret = calloc(nelems, size);
                    ^      ~~~~~~
lscpu.c:661:27: warning: Array access (via field 'polarization') results in a null pointer dereference
                desc->polarization[num] = POLAR_VHIGH;
                      ~~~~~~~~~~~~      ^
lscpu.c:665:27: warning: Array access (via field 'polarization') results in a null pointer dereference
                desc->polarization[num] = POLAR_UNKNOWN;
                      ~~~~~~~~~~~~      ^
lscpu.c:659:27: warning: Array access (via field 'polarization') results in a null pointer dereference
                desc->polarization[num] = POLAR_VMEDIUM;
                      ~~~~~~~~~~~~      ^
lscpu.c:663:27: warning: Array access (via field 'polarization') results in a null pointer dereference
                desc->polarization[num] = POLAR_HORIZONTAL;
                      ~~~~~~~~~~~~      ^
lscpu.c:657:27: warning: Array access (via field 'polarization') results in a null pointer dereference
                desc->polarization[num] = POLAR_VLOW;
                      ~~~~~~~~~~~~      ^
lscpu.c:675:23: warning: Array access (via field 'addresses') results in a null pointer dereference
        desc->addresses[num] = path_getnum(_PATH_SYS_CPU "/cpu%d/address", num);
              ~~~~~~~~~      ^
lscpu.c:685:24: warning: Array access (via field 'configured') results in a null pointer dereference
        desc->configured[num] = path_getnum(_PATH_SYS_CPU "/cpu%d/configure", num);
              ~~~~~~~~~~      ^
8 warnings generated.



CC       readprofile.o
readprofile.c:232:3: warning: The return value from the call to 'setuid' is not checked. If an error occurs in
      'setuid', the following code may execute with unexpected privileges
                setuid(0);
                ^~~~~~



 CC       tunelp.o
tunelp.c:248:11: warning: Memory is never released; potential leak of memory pointed to by 'cmdst'
                        printf(UTIL_LINUX_VERSION);
                               ^~~~~~~~~~~~~~~~~~
../include/c.h:247:78: note: expanded from macro 'UTIL_LINUX_VERSION'
#define UTIL_LINUX_VERSION _("%s from %s\n"), program_invocation_short_name, PACKAGE_STRING
                                                                             ^
../config.h:519:24: note: expanded from macro 'PACKAGE_STRING'
#define PACKAGE_STRING "util-linux 2.21.715-1400"
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
tunelp.c:259:7: warning: Null pointer passed as an argument to a 'nonnull' parameter
        fd = open(filename, O_WRONLY | O_NONBLOCK, 0);
             ^    ~~~~~~~~



CC       rtcwake.o
rtcwake.c:600:13: warning: Memory is never released; potential leak of memory pointed to by 'devname'
        } else if (strcmp(suspend, "disable") == 0) {
                   ^
/usr/include/bits/string2.h:802:13: note: expanded from macro 'strcmp'
  ({ size_t __s1_len, __s2_len;                                               \
            ^



  CC       agetty.o
agetty.c:464:9: warning: Branch condition evaluates to a garbage value
        while (*p) {
               ^~


CC       script.o
script.c:326:16: warning: Assigned value is garbage or undefined
                        childstatus = status;
                                    ^ ~~~~~~



 CC       setterm.o
setterm.c:1197:9: warning: Dereference of null pointer
                        *q++ = *p;
                        ~~~~~^~~~
setterm.c:1204:36: warning: Memory is never released; potential leak of memory pointed to by 'p'
        if (fwrite(outbuf, 1, q - outbuf, F) != (size_t) (q - outbuf)) {
                                          ^
setterm.c:1197:11: warning: Dereference of null pointer (loaded from variable 'p')
                        *q++ = *p;
                               ^~
setterm.c:1202:8: warning: Dereference of null pointer
                *q++ = '\n';
                ~~~~~^~~~~~
setterm.c:1208:8: warning: Memory is never released; potential leak of memory pointed to by 'q'
        close(fd);
              ^~
5 warnings generated.



  CC       more.o
more.c:1592:19: warning: Value stored to 'line3' during its initialization is never read
    register long line3 = startline;
                  ^       ~~~~~~~~~



CC       column.o
column.c:164:2: warning: Value stored to 'argc' is never read
        argc -= optind;
        ^       ~~~~~~
column.c:360:7: warning: Dereference of null pointer (loaded from variable 'p')
                        *p = '\0';
                         ~ ^
In file included from column.c:55:
../include/xalloc.h:45:21: warning: Call to 'calloc' has an allocation size of 0 bytes
        void *ret = calloc(nelems, size);
                    ^      ~~~~~~




-- 

Marek Otahal :o)
