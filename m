Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46917 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab2EaSS6 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 31 May 2012 14:18:58 -0400
Received: by wibhj8 with SMTP id hj8so5248531wib.1
        for <util-linux-ng@vger.kernel.org>; Thu, 31 May 2012 11:18:57 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAG27Bk0E79L9Tb7zi0M6ditsxr46LKJcy6Rn1KqFi5wrxTB4pw@mail.gmail.com>
References: <CAG27Bk3YrUc4cwpUou5o005S165LOc4C8bPHp-EnkwAz2WsFng@mail.gmail.com>
	<4FC72679.7050307@suse.de>
	<CAG27Bk0E79L9Tb7zi0M6ditsxr46LKJcy6Rn1KqFi5wrxTB4pw@mail.gmail.com>
Date: Thu, 31 May 2012 20:18:57 +0200
Message-ID: <CAG27Bk3qA9Xn+fBtPnkjBDVDAts4T4gxWFKFMxskn50FsiPcvA@mail.gmail.com>
Subject: Re: [pull] su.1 manual page
From: Sami Kerola <kerolasa@iki.fi>
To: Ludwig Nussel <ludwig.nussel@suse.de>
Cc: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 31, 2012 at 11:04 AM, Sami Kerola <kerolasa@iki.fi> wrote:
>> PS: the section about the wheel group can be removed :)
>
> I think keeping some sort of note about wheel group not being checked
> is valid information, but does it have to be RMS story is different
> question. I'll have a look of that at evening.

I changed the original patch doing the following. Do you, or anyone
else, have other suggestions how the manual page could be better?

https://raw.github.com/kerolasa/lelux-utiliteetit/su.1/login-utils/su.1


diff --git a/login-utils/su.1 b/login-utils/su.1
index 1847325..8eac714 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -41,10 +41,11 @@ setting argv[0] to -su, passing -c only to certain
shells, etc.).
 can optionally be compiled to use syslog to report failed, and
 optionally successful,
 .B su
-attempts.  (If the system supports syslog.)  However,
+attempts.  (If the system supports syslog.)
+.PP
+This implementation of
 .B su
-does not check if the user is a member of the wheel group; see
-.BR NOTES .
+does not check if the user is a member of the wheel group.
 .SH OPTIONS
 .TP
 \fB\-c\fR, \fB\-\-command\fR [\fIcommand\fR]
@@ -133,30 +134,6 @@ subshell cannot be found
 .B /etc/pam.d/su
 PAM configuration for
 .BR su .
-.SH NOTES
-Why
-.B su
-does not support the
-.I wheel
-group by Richard Stallman.
-.PP
-Sometimes a few of the users try to hold total power over all the
-rest.  For example, in 1984, a few users at the MIT AI lab decided to
-seize power by changing the operator password on the Twenex system
-and keeping it secret from everyone else.  (I was able to thwart this
-coup and give power back to the users by patching the kernel, but I
-wouldn't know how to do that in Unix.)
-.PP
-However, occasionally the rulers do tell someone.  Under the usual
-.B su
-mechanism, once someone learns the root password who sympathizes with
-the ordinary users, he or she can tell the rest.  The "wheel group"
-feature would make this impossible, and thus cement the power of the
-rulers.
-.PP
-I'm on the side of the masses, not that of the rulers.  If you are
-used to supporting the bosses and sysadmins in whatever they do, you
-might find this idea strange at first.
 .SH AUTHORS
 .MT djm@gnu.ai.mit.edu
 David MacKenzie

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
