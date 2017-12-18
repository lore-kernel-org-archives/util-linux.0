Return-Path: lkml@tlinx.org
Message-ID: <5A37BB4F.9080004@tlinx.org>
Date: Mon, 18 Dec 2017 04:57:51 -0800
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Build problem in 2.31
References: <5A37371F.5070307@tlinx.org> <20171218123805.tkhhuyemgntv4gie@ws.net.home>
In-Reply-To: <20171218123805.tkhhuyemgntv4gie@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> Tarball or git tree?
>   
tarball, thanks.... I think these are all the things you
asked for...


> Do you have /usr/include/sys/swap.h? And if yes, what do you have in
> the file? (copy & past).
>   
Dated Feb 24, 2015:
------------------------------------------------------------------------------
/* Calls to enable and disable swapping on specified locations.  Linux 
version.
   Copyright (C) 1996-2014 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, see
   <http://www.gnu.org/licenses/>.  */

#ifndef _SYS_SWAP_H

#define _SYS_SWAP_H 1
#include <features.h>

/* The swap priority is encoded as:
   (prio << SWAP_FLAG_PRIO_SHIFT) & SWAP_FLAG_PRIO_MASK
*/
#define SWAP_FLAG_PREFER  0x8000  /* Set if swap priority is specified. */
#define SWAP_FLAG_PRIO_MASK 0x7fff
#define SWAP_FLAG_PRIO_SHIFT  0
#define SWAP_FLAG_DISCARD 0x10000 /* Discard swap cluster after use.  */

__BEGIN_DECLS

/* Make the block special device PATH available to the system for swapping.
   This call is restricted to the super-user.  */
extern int swapon (const char *__path, int __flags) __THROW;

/* Stop using block special device PATH for swapping.  */
extern int swapoff (const char *__path) __THROW;

__END_DECLS

#endif /* _SYS_SWAP_H */
------------------------------------------------------------------------------

> Please, see also config.h and "SWAPON_HAS_TWO_ARGS" there. 
>
> [Hmm... I think all this SWAPON_HAS_TWO_ARGS is pretty unnecessary,
> swapon() with two args has been introduced by kernel 1.3.2 :-)]
>   
----
    Yikes.... 1.3.2...before my time.
    For swapon_h_2_args:
#define SWAPON_HAS_TWO_ARGS 1


config ops:
#re: array:
alias array='declare -a'

array enable=(  chfn-chsh
                fs-paths-default
                last libmount-support-mtab line
                newgrp
                pg
                silent-rules
                sulogin-emergency-mount
                vipw write )

array disable=( assert nls
                plymouth_support pylibmount
                symvers )

array with=(    bashcompletiondir=/usr/share/bash-completion
                gnu-ld  ncursesw
                readline )

array without=( python systemd )

configure output output:

Running Config:
>../config-231.sh#69> ./configure 'CFLAGS=-fpic -march=native -pipe -Og' 
'LDFLAGS=-fpic -march=native -pipe -Og -Wl,--default-symver -Wl,--stats 
' --prefix=/ --exec-prefix=/ --bindir=/bin --sbindir=/sbin 
--datadir=/share --includedir=/include --oldincludedir=/include 
--libdir=/lib64 --libexecdir=/lib64/util-linux --localstatedir=/var 
--sharedstatedir=/com --sysconfdir=/etc --prefix=/ --bindir=/bin 
--sbindir=/sbin --datadir=/share --includedir=/include 
--oldincludedir=/include --libdir=/lib64 --libexecdir=/lib64/util-linux 
--localstatedir=/var --sharedstatedir=/com --sysconfdir=/etc 
--enable-chfn-chsh --enable-fs-paths-default --enable-last 
--enable-libmount-support-mtab --enable-line --enable-newgrp --enable-pg 
--enable-silent-rules --enable-sulogin-emergency-mount --enable-vipw 
--enable-write --disable-assert --disable-nls --disable-plymouth_support 
--disable-pylibmount --disable-symvers 
--with-bashcompletiondir=/usr/share/bash-completion --with-gnu-ld 
--with-ncursesw --with-readline --without-python --without-systemd
checking for gcc... /usr/bin/gcc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether /usr/bin/gcc accepts -g... yes
checking for /usr/bin/gcc option to accept ISO C89... none needed
checking whether /usr/bin/gcc understands -c and -o together... yes
checking how to run the C preprocessor... /usr/bin/gcc -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking minix/config.h usability... no
checking minix/config.h presence... no
checking for minix/config.h... no
checking whether it is safe to define __EXTENSIONS__... yes
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /usr/bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking for style of include used by make... GNU
checking whether make supports nested variables... yes
checking how to create a pax tar archive... gnutar
checking dependency style of /usr/bin/gcc... gcc3
checking whether make supports nested variables... (cached) yes
configure:   --runstatedir defaults to /run
checking for /usr/bin/gcc option to accept ISO C99... none needed
checking for /usr/bin/gcc option to accept ISO Standard C... (cached) 
none needed
checking for bison... bison -y
checking build system type... x86_64-pc-linux-gnu
checking host system type... x86_64-pc-linux-gnu
checking for an ANSI C-conforming const... yes
checking for working volatile... yes
checking whether byte ordering is bigendian... no
checking whether compiler handles -fno-common... yes
checking whether compiler handles -Wall... yes
checking whether compiler handles -Werror=sequence-point... yes
checking whether compiler handles -Wextra... yes
checking whether compiler handles -Wextra-semi... no
checking whether compiler handles -Wembedded-directive... no
checking whether compiler handles -Wmissing-declarations... yes
checking whether compiler handles -Wmissing-parameter-type... yes
checking whether compiler handles -Wmissing-prototypes... yes
checking whether compiler handles -Wno-missing-field-initializers... yes
checking whether compiler handles -Wredundant-decls... yes
checking whether compiler handles -Wsign-compare... yes
checking whether compiler handles -Wtype-limits... yes
checking whether compiler handles -Wuninitialized... yes
checking whether compiler handles -Wunused-but-set-parameter... yes
checking whether compiler handles -Wunused-but-set-variable... yes
checking whether compiler handles -Wunused-parameter... yes
checking whether compiler handles -Wunused-result... yes
checking whether compiler handles -Wunused-variable... yes
checking whether compiler handles -Wnested-externs... yes
checking whether compiler handles -Wpointer-arith... yes
checking whether compiler handles -Wstrict-prototypes... yes
checking whether compiler handles -Wformat-security... no
checking whether compiler handles -Wimplicit-function-declaration... yes
checking whether compiler handles -Wno-clobbered... yes
checking whether compiler handles -Wno-unused-parameter... yes
checking how to print strings... printf
checking for a sed that does not truncate output... /usr/bin/sed
checking for fgrep... /usr/bin/grep -F
checking for ld used by /usr/bin/gcc... /usr/bin/ld
checking if the linker (/usr/bin/ld) is GNU ld... yes
checking for BSD- or MS-compatible name lister (nm)... /usr/bin/nm -B
checking the name lister (/usr/bin/nm -B) interface... BSD nm
checking whether ln -s works... yes
checking the maximum length of command line arguments... 1572864
checking how to convert x86_64-pc-linux-gnu file names to 
x86_64-pc-linux-gnu format... func_convert_file_noop
checking how to convert x86_64-pc-linux-gnu file names to toolchain 
format... func_convert_file_noop
checking for /usr/bin/ld option to reload object files... -r
checking for objdump... objdump
checking how to recognize dependent libraries... pass_all
checking for dlltool... no
checking how to associate runtime and link libraries... printf %s\n
checking for ar... ar
checking for archiver @FILE support... @
checking for strip... strip
checking for ranlib... ranlib
checking command to parse /usr/bin/nm -B output from /usr/bin/gcc 
object... ok
checking for sysroot... no
checking for a working dd... /usr/bin/dd
checking how to truncate binary pipes... /usr/bin/dd bs=4096 count=1
checking for mt... mt
checking if mt is a manifest tool... no
checking for dlfcn.h... yes
checking for objdir... .libs
checking if /usr/bin/gcc supports -fno-rtti -fno-exceptions... no
checking for /usr/bin/gcc option to produce PIC... -fPIC -DPIC
checking if /usr/bin/gcc PIC flag -fPIC -DPIC works... yes
checking if /usr/bin/gcc static flag -static works... no
checking if /usr/bin/gcc supports -c -o file.o... yes
checking if /usr/bin/gcc supports -c -o file.o... (cached) yes
checking whether the /usr/bin/gcc linker (/usr/bin/ld -m elf_x86_64) 
supports shared libraries... yes
checking whether -lc should be explicitly linked in... no
checking dynamic linker characteristics... GNU/Linux ld.so
checking how to hardcode library paths into programs... immediate
checking whether stripping libraries is possible... yes
checking if libtool supports shared libraries... yes
checking whether to build shared libraries... yes
checking whether to build static libraries... yes
checking linker version script flag... disabled
checking for pkg-config... /usr/bin/pkg-config
checking pkg-config is at least version 0.9.0... yes
checking whether to build gtk-doc documentation... no
checking for gtkdoc-check... /usr/bin/gtkdoc-check
checking for xsltproc... /usr/bin/xsltproc
checking for special C compiler options needed for large files... no
checking for _FILE_OFFSET_BITS value needed for large files... no
checking whether to enable assertions... no
checking whether struct tm is in sys/time.h or time.h... time.h
checking for struct tm.tm_zone... yes
checking whether NLS is requested... no
checking for msgfmt... /usr/bin/msgfmt
checking for gmsgfmt... /usr/bin/msgfmt
checking for xgettext... /usr/bin/xgettext
checking for msgmerge... /usr/bin/msgmerge
checking for ld used by /usr/bin/gcc... /usr/bin/ld -m elf_x86_64
checking if the linker (/usr/bin/ld -m elf_x86_64) is GNU ld... yes
checking for shared library run path origin... done
checking for CFPreferencesCopyAppValue... no
checking for CFLocaleCopyCurrent... no
checking whether to use NLS... no
checking for linux/compiler.h... no
checking for linux/blkpg.h... yes
checking for linux/major.h... yes
checking asm/io.h usability... no
checking asm/io.h presence... no
checking for asm/io.h... no
checking err.h usability... yes
checking err.h presence... yes
checking for err.h... yes
checking errno.h usability... yes
checking errno.h presence... yes
checking for errno.h... yes
checking fcntl.h usability... yes
checking fcntl.h presence... yes
checking for fcntl.h... yes
checking getopt.h usability... yes
checking getopt.h presence... yes
checking for getopt.h... yes
checking for inttypes.h... (cached) yes
checking lastlog.h usability... yes
checking lastlog.h presence... yes
checking for lastlog.h... yes
checking libutil.h usability... no
checking libutil.h presence... no
checking for libutil.h... no
checking linux/btrfs.h usability... yes
checking linux/btrfs.h presence... yes
checking for linux/btrfs.h... yes
checking linux/cdrom.h usability... yes
checking linux/cdrom.h presence... yes
checking for linux/cdrom.h... yes
checking linux/falloc.h usability... yes
checking linux/falloc.h presence... yes
checking for linux/falloc.h... yes
checking linux/watchdog.h usability... yes
checking linux/watchdog.h presence... yes
checking for linux/watchdog.h... yes
checking linux/fd.h usability... yes
checking linux/fd.h presence... yes
checking for linux/fd.h... yes
checking linux/raw.h usability... yes
checking linux/raw.h presence... yes
checking for linux/raw.h... yes
checking linux/tiocl.h usability... yes
checking linux/tiocl.h presence... yes
checking for linux/tiocl.h... yes
checking linux/version.h usability... yes
checking linux/version.h presence... yes
checking for linux/version.h... yes
checking linux/securebits.h usability... yes
checking linux/securebits.h presence... yes
checking for linux/securebits.h... yes
checking locale.h usability... yes
checking locale.h presence... yes
checking for locale.h... yes
checking mntent.h usability... yes
checking mntent.h presence... yes
checking for mntent.h... yes
checking net/if.h usability... yes
checking net/if.h presence... yes
checking for net/if.h... yes
checking net/if_dl.h usability... no
checking net/if_dl.h presence... no
checking for net/if_dl.h... no
checking netinet/in.h usability... yes
checking netinet/in.h presence... yes
checking for netinet/in.h... yes
checking paths.h usability... yes
checking paths.h presence... yes
checking for paths.h... yes
checking pty.h usability... yes
checking pty.h presence... yes
checking for pty.h... yes
checking security/pam_appl.h usability... yes
checking security/pam_appl.h presence... yes
checking for security/pam_appl.h... yes
checking for stdint.h... (cached) yes
checking stdio_ext.h usability... yes
checking stdio_ext.h presence... yes
checking for stdio_ext.h... yes
checking for stdlib.h... (cached) yes
checking endian.h usability... yes
checking endian.h presence... yes
checking for endian.h... yes
checking byteswap.h usability... yes
checking byteswap.h presence... yes
checking for byteswap.h... yes
checking sys/endian.h usability... no
checking sys/endian.h presence... no
checking for sys/endian.h... no
checking sys/disk.h usability... no
checking sys/disk.h presence... no
checking for sys/disk.h... no
checking sys/disklabel.h usability... no
checking sys/disklabel.h presence... no
checking for sys/disklabel.h... no
checking sys/file.h usability... yes
checking sys/file.h presence... yes
checking for sys/file.h... yes
checking sys/io.h usability... yes
checking sys/io.h presence... yes
checking for sys/io.h... yes
checking sys/ioccom.h usability... no
checking sys/ioccom.h presence... no
checking for sys/ioccom.h... no
checking sys/ioctl.h usability... yes
checking sys/ioctl.h presence... yes
checking for sys/ioctl.h... yes
checking sys/mkdev.h usability... no
checking sys/mkdev.h presence... no
checking for sys/mkdev.h... no
checking sys/mount.h usability... yes
checking sys/mount.h presence... yes
checking for sys/mount.h... yes
checking sys/param.h usability... yes
checking sys/param.h presence... yes
checking for sys/param.h... yes
checking sys/prctl.h usability... yes
checking sys/prctl.h presence... yes
checking for sys/prctl.h... yes
checking sys/resource.h usability... yes
checking sys/resource.h presence... yes
checking for sys/resource.h... yes
checking sys/signalfd.h usability... yes
checking sys/signalfd.h presence... yes
checking for sys/signalfd.h... yes
checking sys/socket.h usability... yes
checking sys/socket.h presence... yes
checking for sys/socket.h... yes
checking sys/sockio.h usability... no
checking sys/sockio.h presence... no
checking for sys/sockio.h... no
checking for sys/stat.h... (cached) yes
checking sys/sysmacros.h usability... yes
checking sys/sysmacros.h presence... yes
checking for sys/sysmacros.h... yes
checking sys/swap.h usability... yes
checking sys/swap.h presence... yes
checking for sys/swap.h... yes
checking sys/syscall.h usability... yes
checking sys/syscall.h presence... yes
checking for sys/syscall.h... yes
checking sys/time.h usability... yes
checking sys/time.h presence... yes
checking for sys/time.h... yes
checking sys/timex.h usability... yes
checking sys/timex.h presence... yes
checking for sys/timex.h... yes
checking sys/ttydefaults.h usability... yes
checking sys/ttydefaults.h presence... yes
checking for sys/ttydefaults.h... yes
checking for sys/types.h... (cached) yes
checking sys/ucred.h usability... no
checking sys/ucred.h presence... no
checking for sys/ucred.h... no
checking sys/un.h usability... yes
checking sys/un.h presence... yes
checking for sys/un.h... yes
checking for unistd.h... (cached) yes
checking shadow.h usability... yes
checking shadow.h presence... yes
checking for shadow.h... yes
checking utmp.h usability... yes
checking utmp.h presence... yes
checking for utmp.h... yes
checking utmpx.h usability... yes
checking utmpx.h presence... yes
checking for utmpx.h... yes
checking for linux/gsmmux.h... no
checking for security/pam_misc.h... yes
checking linux/blkzoned.h usability... no
checking linux/blkzoned.h presence... no
checking for linux/blkzoned.h... no
checking for security/openpam.h... no
checking langinfo.h usability... yes
checking langinfo.h presence... yes
checking for langinfo.h... yes
checking for struct termios.c_line... yes
checking for struct stat.st_mtim.tv_nsec... yes
checking whether _NL_TIME_WEEK_1STDAY is declared... yes
checking whether llseek is declared... no
checking whether lseek64 is declared... yes
checking whether environ is declared... yes
checking whether strsignal is declared... yes
checking whether TIOCGLCKTRMIOS is declared... yes
checking whether SOCK_CLOEXEC is declared... yes
checking whether SOCK_NONBLOCK is declared... yes
checking whether SO_PASSCRED is declared... yes
checking for __fpending... yes
checking for secure_getenv... yes
checking for __secure_getenv... no
checking for err... yes
checking for errx... yes
checking for explicit_bzero... no
checking for fsync... yes
checking for utimensat... yes
checking for getdomainname... yes
checking for getdtablesize... yes
checking for getexecname... no
checking for getmntinfo... no
checking for getrandom... no
checking for getrlimit... yes
checking for getsgnam... yes
checking for inotify_init... yes
checking for jrand48... yes
checking for lchown... yes
checking for llseek... yes
checking for lseek64... yes
checking for mempcpy... yes
checking for mkostemp... yes
checking for nanosleep... yes
checking for ntp_gettime... yes
checking for personality... yes
checking for posix_fadvise... yes
checking for prctl... yes
checking for qsort_r... yes
checking for rpmatch... yes
checking for scandirat... yes
checking for setprogname... no
checking for setresgid... yes
checking for setresuid... yes
checking for sched_setattr... no
checking for sched_setscheduler... yes
checking for sigqueue... yes
checking for srandom... yes
checking for strnchr... no
checking for strndup... yes
checking for strnlen... yes
checking for sysconf... yes
checking for sysinfo... yes
checking for timegm... yes
checking for usleep... yes
checking for vwarnx... yes
checking for warn... yes
checking for warnx... yes
checking for _LARGEFILE_SOURCE value needed for large files... no
checking for openat... yes
checking for fstatat... yes
checking for unlinkat... yes
checking for ioperm... yes
checking for iopl... yes
checking for futimens... yes
checking for inotify_init1... yes
checking for open_memstream... yes
checking for reboot... yes
checking for updwtmpx... yes
checking for updwtmpx... (cached) yes
checking for getusershell... yes
checking for isnan... yes
checking for clock_gettime... yes
checking for timer_create... no
checking for timer_create in -lrt... yes
checking for rtas_get_sysparm in -lrtas... no
checking for struct sockaddr.sa_len... no
checking for library containing socket... none required
checking for dirfd... yes
checking whether program_invocation_short_name is defined... yes
checking whether __progname is defined... yes
checking whether the target supports thread-local storage... yes
checking scanf string alloc modifiers... (%ms) yes
checking for openpty in -lutil... yes
checking for union semun... no
checking for loff_t... yes
checking wchar_t support... yes
checking for cpu_set_t... yes
checking for sighandler_t... yes
checking whether CPU_ALLOC is declared... yes
checking crypt.h usability... yes
checking crypt.h presence... yes
checking for crypt.h... yes
checking for udev_new in -ludev... yes
checking for ncursesw6-config... ncursesw6-config
checking ncursesw/ncurses.h usability... yes
checking ncursesw/ncurses.h presence... yes
checking for ncursesw/ncurses.h... yes
checking ncursesw/term.h usability... yes
checking ncursesw/term.h presence... yes
checking for ncursesw/term.h... yes
checking for use_default_colors in -lncursesw... yes
checking for resizeterm in -lncursesw... yes
checking for TINFOW... no
checking for tgetent in -ltinfow... no
checking for TINFO... yes
checking for readline in -lreadline... yes
checking for syscall fallocate... SYS_fallocate
checking for valid fallocate() function... yes
checking for valid posix_fallocate() function... yes
checking for syscall unshare... SYS_unshare
checking for unshare... yes
checking for syscall setns... SYS_setns
checking for setns... yes
checking for capng_apply in -lcap-ng... yes
checking for crc32 in -lz... yes
checking for syscall prlimit64... SYS_prlimit64
checking for prlimit... yes
checking for syscall pivot_root... SYS_pivot_root
configure: WARNING: linux/blkzoned.h header not found; not building blkzone
checking for LIBUSER... no
checking for syscall ioprio_set... SYS_ioprio_set
checking for syscall ioprio_get... SYS_ioprio_get
checking for syscall sched_getaffinity... SYS_sched_getaffinity
checking for syscall sched_setattr... SYS_sched_setattr
Package systemd was not found in the pkg-config search path.
Perhaps you should add the directory containing `systemd.pc'
to the PKG_CONFIG_PATH environment variable
No package 'systemd' found
checking that generated files are newer than configure... done
configure: creating ./config.status
config.status: creating Makefile
config.status: creating libblkid/docs/Makefile
config.status: creating libblkid/docs/version.xml
config.status: creating libblkid/src/blkid.h
config.status: creating libfdisk/docs/Makefile
config.status: creating libfdisk/docs/version.xml
config.status: creating libfdisk/src/libfdisk.h
config.status: creating libmount/docs/Makefile
config.status: creating libmount/docs/version.xml
config.status: creating libmount/src/libmount.h
config.status: creating libsmartcols/docs/Makefile
config.status: creating libsmartcols/docs/version.xml
config.status: creating libsmartcols/src/libsmartcols.h
config.status: creating po/Makefile.in
config.status: creating config.h
config.status: executing depfiles commands
config.status: executing libtool commands
config.status: executing po-directories commands
config.status: creating po/POTFILES
config.status: creating po/Makefile

  util-linux  2.31

  prefix:            /
  exec prefix:       /

  runstatedir:       /run
  bindir:            /bin
  sbindir:           /sbin
  libdir:            /lib64
  includedir:        /include
  usrbin_execdir:    ${exec_prefix}/bin
  usrsbin_execdir:   ${exec_prefix}/sbin
  usrlib_execdir:    ${exec_prefix}/lib64

  compiler:          /usr/bin/gcc
  cflags:            -fpic -march=native -pipe -Og
  suid cflags:      
  ldflags:           -fpic -march=native -pipe -Og -Wl,--default-symver 
-Wl,--stats
  suid ldflags:     

  Python:           
  Python version:   
  Python libs:      

  Bash completions:  /usr/share/bash-completion
  Systemd support:   no
  Btrfs support:     yes
  Wide-char support: yes

  warnings:

 -fno-common -Wall -Werror=sequence-point -Wextra -Wmissing-declarations 
-Wmissing-parameter-type -Wmissing-prototypes 
-Wno-missing-field-initializers -Wredundant-decls -Wsign-compare 
-Wtype-limits -Wuninitialized -Wunused-but-set-parameter 
-Wunused-but-set-variable -Wunused-parameter -Wunused-result 
-Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes 
-Wimplicit-function-declaration

  Type 'make' or 'make <utilname>' to compile.
