Return-Path: util-linux-owner@vger.kernel.org
Received: from mout0.freenet.de ([195.4.92.90]:49548 "EHLO mout0.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752037Ab2JDEuG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 4 Oct 2012 00:50:06 -0400
Received: from [195.4.92.142] (helo=mjail2.freenet.de)
	by mout0.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.76 #1)
	id 1TJdNs-00038O-JD
	for util-linux@vger.kernel.org; Thu, 04 Oct 2012 06:50:04 +0200
Received: from localhost ([::1]:36986 helo=mjail2.freenet.de)
	by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.76 #1)
	id 1TJdNs-0005v6-D8
	for util-linux@vger.kernel.org; Thu, 04 Oct 2012 06:50:04 +0200
Received: from [195.4.92.15] (port=39368 helo=5.mx.freenet.de)
	by mjail2.freenet.de with esmtpa (ID andihartmann@freenet.de) (Exim 4.76 #1)
	id 1TJdLY-0005nL-5N
	for util-linux@vger.kernel.org; Thu, 04 Oct 2012 06:47:40 +0200
Received: from p4fde046d.dip0.t-ipconnect.de ([79.222.4.109]:33226 helo=mail.maya.org)
	by 5.mx.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1:AES256-SHA:256) (port 25) (Exim 4.76 #1)
	id 1TJdLX-0006yQ-Rk
	for util-linux@vger.kernel.org; Thu, 04 Oct 2012 06:47:40 +0200
Received: from dualc.maya.org (dualc.maya.org [192.168.1.6])
	by mail.maya.org (8.14.5/8.13.8) with ESMTP id q944la8H002334
	for <util-linux@vger.kernel.org>; Thu, 4 Oct 2012 06:47:36 +0200
Date: Thu, 4 Oct 2012 06:47:36 +0200
From: Andreas Hartmann <andihartmann@01019freenet.de>
To: util-linux@vger.kernel.org
Subject: Questions concerning fstrim and online discard.
Message-ID: <20121004064736.64caef77@dualc.maya.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello!

Please, may I ask you some questions because I'm a little bit confused
about the behaviour of fstrim and online discard (ext4)?


I'm using the following configuration / partitioning with a SSD
(Controller: SF-2281; Corsair Force GT 240GB):

- dm_crypt: cryptsetup luksOpen - version 1.4.1, device-mapper
  version 1.02.75
- lvm version 2.02.96
- ext4, option discard; kernel version 3.4.11

All seems to work fine, I can't see any errors in messages or in dmesg
according trim / discard.

Now, I tested fstrim from util-linux version 2.19, and surprisingly got
this unexpected error:

fstrim: /: FITRIM ioctl failed: Operation not supported

Why do I get this error? Online discard always seemed to work fine (= I
didn't get any error).

I detected, that there is another necessary option to get a
working fstrim:
cryptsetup luksOpen must be run with option --allow-discards.


Now my questions:
- Did online discard work without --allow-discards? If not, why didn't I
  get any error message?
- Is there a difference between online discard and fstrim, means,
  fstrim doesn't work without --allow-discards, but online discard does?
- fstrim / always says after each reboot:
  /: 1701429248 bytes was trimmed
  This can't be true as the root partition contains mainly root and
  nothing else (no /var or /usr or even /opt). There has been no
  changes in fs since last power on / off cycle and fstrim during the
  last cycle.
  Doesn't fstrim remember the already trimmed regions? Does it trim
  always the complete unused regions?
- Which trim should be used with a SF-2281 controller concerning
  endurance? fstrim or online discard?


Thank you very much for your advice!
Kind regards,
Andreas
