Return-Path: ah@fatal.se
Date: Tue, 1 Sep 2015 16:13:27 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] hwclock: fix signed/unsigned comparison warning on
 alpha
Message-ID: <20150901141327.GA17192@fatal.se>
References: <1440166409-32215-1-git-send-email-andreas@fatal.se>
 <20150824085835.GK1689@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
In-Reply-To: <20150824085835.GK1689@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

On Mon, Aug 24, 2015 at 10:58:35AM +0200, Karel Zak wrote:
> On Fri, Aug 21, 2015 at 04:13:27PM +0200, Andreas Henriksson wrote:
> >  sys-utils/hwclock.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Applied all three patches. It would be nice to test it on alphas.
> Thanks.

The alpha buildds has now caught up and a full build log of 2.27-rc2
is available here:
https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=alpha&ver=2.27~rc2-2&stamp=1441074407

(Other architectures build logs available by clicking "Installed" on this page:
https://buildd.debian.org/status/package.php?p=util-linux&suite=experimental )

The committed patches seems to have had the desired effect and fixed
the compiler warnings they where aiming at.

Remaining warnings for alpha arch specific code in hwclock:

gcc -DHAVE_CONFIG_H -I.  -include config.h -I./include -DLOCALEDIR=\"/usr/share/locale\" -D_PATH_LOCALSTATEDIR=\"/run\" -D_FORTIFY_SOURCE=2 -fsigned-char -fno-common -Wall -Werror=sequence-point -Wextra -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wno-missing-field-initializers -Wredundant-decls -Wsign-compare -Wtype-limits -Wuninitialized -Wunused-but-set-parameter -Wunused-but-set-variable -Wunused-parameter -Wunused-result -Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes -Wimplicit-function-declaration -g -O2 -Wformat -Werror=format-security -c -o sys-utils/hwclock.o sys-utils/hwclock.c
In file included from ./include/nls.h:24:0,
                 from ./include/closestream.h:11,
                 from sys-utils/hwclock.c:77:
sys-utils/hwclock.c: In function 'manipulate_epoch':
sys-utils/hwclock.c:1471:12: warning: format '%d' expects argument of type 'int', but argument 2 has type 'long unsigned int' [-Wformat=]
           ("Not setting the epoch to %d - testing only.\n"),
            ^
sys-utils/hwclock.c:1470:11: note: in expansion of macro '_'
    printf(_
           ^
gcc -DHAVE_CONFIG_H -I.  -include config.h -I./include -DLOCALEDIR=\"/usr/share/locale\" -D_PATH_LOCALSTATEDIR=\"/run\" -D_FORTIFY_SOURCE=2 -fsigned-char -fno-common -Wall -Werror=sequence-point -Wextra -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wno-missing-field-initializers -Wredundant-decls -Wsign-compare -Wtype-limits -Wuninitialized -Wunused-but-set-parameter -Wunused-but-set-variable -Wunused-parameter -Wunused-result -Wunused-variable -Wnested-externs -Wpointer-arith -Wstrict-prototypes -Wimplicit-function-declaration -g -O2 -Wformat -Werror=format-security -c -o sys-utils/hwclock-cmos.o sys-utils/hwclock-cmos.c
sys-utils/hwclock-cmos.c: In function 'set_cmos_epoch':
sys-utils/hwclock-cmos.c:183:19: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
  if (epoch_option != -1) {
                   ^
sys-utils/hwclock-cmos.c: In function 'atomic':
sys-utils/hwclock-cmos.c:290:3: warning: output constraint '=' for operand 0 is not at the beginning
   asm volatile ("rpcc %0":"r=" (ts1));
   ^
sys-utils/hwclock-cmos.c:292:3: warning: output constraint '=' for operand 0 is not at the beginning
   asm volatile ("rpcc %0":"r=" (ts2));
   ^
sys-utils/hwclock-cmos.c:290:3: warning: output constraint '=' for operand 0 is not at the beginning
   asm volatile ("rpcc %0":"r=" (ts1));
   ^
sys-utils/hwclock-cmos.c:292:3: warning: output constraint '=' for operand 0 is not at the beginning
   asm volatile ("rpcc %0":"r=" (ts2));
   ^
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
 atomic(const char *name, unsigned long (*op) (unsigned long), unsigned long arg)
 ^
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
 }
 ^
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:678:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
 atomic(const char *name, unsigned long (*op) (unsigned long), unsigned long arg)
 ^
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:285:1: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:290:3: warning: output constraint '=' for operand 0 is not at the beginning
   asm volatile ("rpcc %0":"r=" (ts1));
   ^
sys-utils/hwclock-cmos.c:290:3: warning: output constraint '=' for operand 0 is not at the beginning
sys-utils/hwclock-cmos.c:292:3: warning: output constraint '=' for operand 0 is not at the beginning
   asm volatile ("rpcc %0":"r=" (ts2));
   ^
sys-utils/hwclock-cmos.c:292:3: warning: output constraint '=' for operand 0 is not at the beginning


The first warning should be trivially fixed by the attached patch,
changing a %d to %lu for printing epoch_opt.
The hwclock-cmos.c sign/unsigned comparison could be fixed by
including limits.h and using ULONG_MAX instead of -1 in epoch_option
comparison, similar to what was done in hwclock.c already.
Not sure how to deal with the assembler warnings....

Regards,
Andreas Henriksson

--DocE+STaALJfprDB
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="ul-alpha-hwclock-fix-format-warning.patch"

From: Andreas Henriksson <andreas@fatal.se>
Subject: hwclock: fix format warning in alpha code

Signed-off-by: Andreas Henriksson <andreas@fatal.se>

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index bdb98e2..4b201d7 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1458,7 +1458,7 @@ manipulate_epoch(const bool getepoch,
 			       "option to tell to what value to set it."));
 		else if (testing)
 			printf(_
-			       ("Not setting the epoch to %d - testing only.\n"),
+			       ("Not setting the epoch to %lu - testing only.\n"),
 			       epoch_opt);
 		else if (set_epoch_rtc(epoch_opt))
 			printf(_

--DocE+STaALJfprDB--
