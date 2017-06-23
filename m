Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:60166 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753849AbdFWVik (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Jun 2017 17:38:40 -0400
From: "W. Trevor King" <wking@tremily.us>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2 2/8] sys-utils/fstab.5: Remove 'defaults' from examples
Date: Fri, 23 Jun 2017 14:30:20 -0700
Message-Id: <711d668bfd6f6466fce75f1dfae8d21deaa4e924.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
In-Reply-To: <cover.1498252231.git.wking@tremily.us>
References: <cover.1498252231.git.wking@tremily.us>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For each option ((no)auto, rw/ro, etc.), whether an informed user
should explicitly set an option in the fstab entry depends on
something like the following decision tree:

a. If you have a preference (e.g. you want a rw mount)...

   a. If the default is unreliable (e.g. you don't trust the admin who
      configured some tune2fs defaults, or you don't trust the Linux
      devs to not make ro the default in the future), then explicitly
      set the option.

   b. If the default is reliable (e.g. you trust the Linux devs to
      continue to default to rw)...

      a. If your preference matches the default (e.g. you prefer rw
         and the kernel default is rw)...

         a. If you like being explicit, explicitly set the option.

         b. You don't mind being implicit, so leave the option unset.

      b. Your preference does not match the default (e.g. you prefer
         rw), so explicitly set the option.

b. You don't have a preference (e.g. you're fine leaving (no)lazytime
   up to the kernel devs, even if they change their mind), so leave
   the option unset.

'defaults' is a no-op placeholder where you fall into either case
a.b.a.b or case b for *every* possible option.  Once you have a
preference on any option (e.g. you want to use auto_da_alloc and you
don't want to rely on 'tune2fs -o auto_da_alloc', putting you in case
a.a for that option), there's no reason to use defaults.

Falling into case b for every option seems unlikely for a "typical"
example.  Falling into case a.b.a.b for every option is more
reasonable, but neither "is the setting reliable?" (the switch between
case a.a and case a.b) no "do you like being explicit?" (the switch
between case a.b.a.a. and case a.b.a.b) seem like likely choices to
take a hard line on.  Using an explicit setting (e.g. rw, as in the
first example added by this commit) instead of defaults gives you some
paranoid protection from a swapped default at no cost (even saving a
few characters ;).

The label values (MyHomeDev and MyOptDev) are Karel's suggestions [1].
I'd probably use "home" and "opt" as the labels in my own fstab, but
Karel's values make it more clear that the labels are independent from
the target directory.

[1]: Message-ID: <20170512075451.auqemicjfogreepq@ws.net.home>
     Subject: Re: [PATCH] WIP: mount.8: Split out fstab-specific mount options
     Date: Fri, 12 May 2017 09:54:51 +0200

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 sys-utils/fstab.5 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/fstab.5 b/sys-utils/fstab.5
index d292f1f..f3eeda4 100644
--- a/sys-utils/fstab.5
+++ b/sys-utils/fstab.5
@@ -57,12 +57,13 @@ Each filesystem is described on a separate line.
 Fields on each line are separated by tabs or spaces.
 Lines starting with '#' are comments.  Blank lines are ignored.
 .PP
-The following is a typical example of an
+The following are two typical
 .B fstab
-entry:
+entries:
 .sp
 .RS 7
-LABEL=t-home2   /home      ext4    defaults,auto_da_alloc      0  2
+LABEL=MyHomeDev  /home  ext4  rw             0  2
+LABEL=MyOptDev   /opt   ext4  auto_da_alloc  0  2
 .RE
 
 .B The first field
-- 
2.1.0.60.g85f0837

