Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:53895 "EHLO Ishtar.tlinx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966369Ab3E2UMV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 May 2013 16:12:21 -0400
Received: from [192.168.4.12] (Athenae [192.168.4.12])
	by Ishtar.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id r4TKBmMa076248
	for <util-linux@vger.kernel.org>; Wed, 29 May 2013 13:11:50 -0700
Message-ID: <51A66104.3060508@tlinx.org>
Date: Wed, 29 May 2013 13:11:48 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: RFD: patch: su: ignoring switches and continuing:  --preserve-environment v. --login
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>





> @@ -98,6 +98,7 @@ Preserves the whole environment, ie does not set
>  .B USER
>  nor
>  .BR LOGNAME .
> +The option is ignored if the option \fB\-\-login\fR is specified.
---
There are 2 problems
On the surface, this patch, alone, appears to remove desirable
functionality from su, and, it is a dangerous change in default
function to make to a previously existing command that may
be scripted.

I can easily see scripts that expect the environment to be preserved
after su/with login EXCEPT for things that would have to change
(like logname, UID EUID USER).

In the best case, I would like to see this semantic preserved, though
if not through the combined use of these switches, through an alternative
set of switches.

However, if someone thinks this functionality cannot be provided with
these switches and wants to move that functionality to a new set of
switches (or are they suggesting shipping a crippled 'su' that no
longer allows this?), then simply ignoring the "keep-env" and
executing a command would be dangerous if those commands rely on
information in ENV for proper execution.

To simply ignore 'keep', is the worse outcome -- because you don't want
a command that has likely just switched to root, to have ENV vars
it depends on destroyed.  If su is about to run a series of command --
maybe used with '-c' and quotes, and contains something like:

  -c 'bash -c '\''cd "${BUILDROOT}/" && find . -delete'\'''

If you ignore the keep-env, but continued execution as root then
such a command would wipe the system.

If you need break that functionality, then the combination of those
switches should NOT execute the subsequent command -- the command should
fail.

OTOH, one would ask how does one switch to a  new USER/LOGNAME while
keeping all the rest of their ENV intact, as is now possible?
Are you saying "we are shipping a new 'su' without this ability"?

Then I'd ask how is shipping an 'su' program without this flexibility
useful to the user base?   If a site policy wants to restrict this
usage, there are other ways to that, but we aren't talking the
"average user" -- we are talking about a facility that is only
usable by system-owners and admins -- i.e. people authorized to
use such a command.  Removing this functionality wouldn't impact
normal users who are not authorized to 'su' to another USERID
such as root (or whoever), but would only impact those who
design system-policy.  I would strongly the usefulness of such a
change.













