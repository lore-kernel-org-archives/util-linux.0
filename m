Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751675AbcLGLZo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Dec 2016 06:25:44 -0500
Date: Wed, 7 Dec 2016 12:25:41 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Marian Vomir <marian.vomir@ni.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "hwclock: don't allow non-root access"
Message-ID: <20161207112541.2g3trc26tcvcghio@ws.net.home>
References: <1481047580-28284-1-git-send-email-marian.vomir@ni.com>
 <c0ddbe5a-caa4-c8ad-0d86-9b13c3277edc@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c0ddbe5a-caa4-c8ad-0d86-9b13c3277edc@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 06, 2016 at 06:40:32PM -0500, J William Piggott wrote:
> 
> 
> On 12/06/2016 01:06 PM, Marian Vomir wrote:
> > This reverts commit 687cc5d58942b24a9f4013c68876d8cbea907ab1.
> > 
> > There are cases when an unprivileged user wants to set the hardware clock.
> 
> This has never been allowed in over two decades of hwclock. I cannot
> think of a legitimate reason to allow setting the Hardware Clock by a
> normal user.

Yes. It seems Marian has missed the goal of the commit
687cc5d58942b24a9f4013c68876d8cbea907ab1. It's not about permissions
detection. 

We don't want to support use-case where hwclock(8) has extra
permissions (setuid or CAP_<something>) to set system time. The binary
is not designed for this purpose and it does not make sense to support
it -- less utils with extra permissions is better.

> Having said that, while I agree with Karel's desire to remove all
> mention of running hwclock with setuid, IMO the code should not have
> been removed. Despite the comment directly above it, that code has
> nothing to do with hwclock being run with setuid.

Maybe my patch seems too strict, but change docs is not enough, the
code matters. We want to be sure nobody uses hwclock as setuid,
especially if man page and code comments promised this non-sense.

> I would argue that there are some hwclock options intended for normal
> users. A normal users should at least be able to display the Hardware
> Clock time.

We can change it to support --show for non-root users, but the
question is if such change will have any practical effect, because for
example on Fedora we have:

  $ ll /dev/rtc0
  crw------- 1 root root 251, 0 Nov 28 10:46 /dev/rtc0

so

  $ hwclock --debug --show
  hwclock from util-linux 2.29.44-a99c0
  hwclock: cannot open /dev/rtc: Permission denied
  No usable clock interface found.
  hwclock: Cannot access the Hardware Clock via any known method.

with the untested patch below. IMHO it's waste of time to try to be
smart in this area... ;-)

    Karel



diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 21caeb2..ede6cfa 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1859,11 +1859,6 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
-	if (getuid() != 0) {
-		warnx(_("Sorry, only the superuser can use the Hardware Clock."));
-		hwclock_exit(EX_NOPERM);
-	}
-
 #ifdef HAVE_LIBAUDIT
 	if (testing != TRUE) {
 		if (adjust == TRUE || hctosys == TRUE || systohc == TRUE ||
@@ -1906,6 +1901,11 @@ int main(int argc, char **argv)
 		show = 1;	/* default to show */
 
 
+	if (!show && getuid() != 0) {
+		warnx(_("Sorry, only --show is allowed for non-root users."));
+		hwclock_exit(EX_NOPERM);
+	}
+
 #ifdef __linux__
 	if (getepoch || setepoch) {
 		manipulate_epoch(getepoch, setepoch, epoch_option, testing);

