Return-Path: util-linux-owner@vger.kernel.org
Received: from lekensteyn.nl ([178.21.112.251]:53493 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbaJONbp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Oct 2014 09:31:45 -0400
From: Peter Wu <peter@lekensteyn.nl>
To: linux-ide@vger.kernel.org, util-linux@vger.kernel.org
Subject: blkdiscard vs hdparm for erasing a SSD?
Date: Wed, 15 Oct 2014 15:12:42 +0200
Message-ID: <2523736.cvg5kvG8qa@al>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

Recent versions of util-linux have a blkdiscard program. How does this compare
to the --security-erase option of hdparm? The goal is to erase the contents of
an previously used SSD to improve performance.

Is the command `blkdiscard -s /dev/sdd` equivalent to the instructions listed on
https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase?
-- 
Kind regards,
Peter
https://lekensteyn.nl

