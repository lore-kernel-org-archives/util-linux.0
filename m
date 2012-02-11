Return-Path: util-linux-owner@vger.kernel.org
Received: from enyo.dsw2k3.info ([195.71.86.239]:56709 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920Ab2BKMhf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 11 Feb 2012 07:37:35 -0500
Received: from localhost (localhost [127.0.0.1])
	by enyo.dsw2k3.info (Postfix) with ESMTP id BE38C98C930
	for <util-linux@vger.kernel.org>; Sat, 11 Feb 2012 13:30:32 +0100 (CET)
Received: from enyo.dsw2k3.info ([127.0.0.1])
	by localhost (enyo.dsw2k3.info [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2uYgvvj4ezW2 for <util-linux@vger.kernel.org>;
	Sat, 11 Feb 2012 13:30:20 +0100 (CET)
Received: from citd.de (p4FC4D289.dip.t-dialin.net [79.196.210.137])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	by enyo.dsw2k3.info (Postfix) with ESMTPSA id ED10498C6B1
	for <util-linux@vger.kernel.org>; Sat, 11 Feb 2012 13:30:18 +0100 (CET)
Date: Sat, 11 Feb 2012 13:30:16 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: util-linux@vger.kernel.org
Subject: What about a premount/postumount option for mount?
Message-ID: <20120211123016.GA15097@citd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi


I'm currently determining how i can integrate dm-crypt devices cleanly
with autofs (via a "ghostable" indirect-map, so nothing to exec there).

What would be ideal is setting up the dm-crypt at mount-time and also to 
do the teardown immediately after umount.

The first thing should be quite easy to do, even without the help of 
mount, and could be e.g. implemented via a udev-script. So that after 
pluging in a USB-disc the corrosponding dm-crypt device can be setup, 
which afterwards would be automountable.

Alternativly i could use an 'executable' map-type on the autofs-site, 
but i don't want to do that because that can't "ghost" (Ghosting shows 
all possible directories, which make "Tab completion" and browsing 
though a file-dialog possible (for currently NOT mounted sub-directories 
in an indirect-map)). But as far as i can tell that is also only a 
half-solution, because i there is nothing executed at umount-time, so 
automatic teardown still wouldn't work.

For the umount thing, i think i could use inotify and wait for the 
"umount"-event as inotify fortunately doesn't prevent umount, but that 
works a little against the spirit of autofs, as it only would work once 
(at least in the case of setup by udev).

All "solutions" taste a little strange for me, the udev-solution mainly 
because i would have a dm-crypt "laying" around which may or may not be 
used and the automatic tear-down after umount because what if it just 
timed out and i want it to use again would only work with an exec-type 
map where i could to the setup. Only doing the teardown of the dm-crypt 
after the device is unplugged does not sound right to me either, because 
i don't know if that is safe. My question if unplugging a device, with a 
dm-crypt device in existence, is safe was met with silence.

All crutches would not be needed if there was a "premount" and "postumount" 
option/command in mount that could do something "just before mount" and 
"just after umount". Either "per mount" or "always".

I guess the easiest solution would be if mount would check for 
/sbin/mount.premount and execute that before the mount took place, with 
all the commandline parameters passed to the program and the same after 
umount with /sbin/mount.postumount or something like that.

This solution would also make for e.g. "loop-aes" more easily usable, 
currently one has to use a patched version of mount/losetup. With a 
premount/postumount-command/option it would be possible to use an unpatched 
mount-binary and do the loop-aes setup/teardown "somewhere else", which 
would at least alleviate the need for a patched mount command for the 
usecases where there is no interactivity (e.g. with a "cleartextkey" or 
a gpg-key when a usable gpg-agent is running).







Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

