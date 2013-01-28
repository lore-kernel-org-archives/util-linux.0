Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.collax.com ([213.218.25.154]:55775 "EHLO mail.collax.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135Ab3A1VxO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jan 2013 16:53:14 -0500
Received: from localhost (mail.collax.com [127.0.0.1])
	by localhost (Postfix) with ESMTP id 09B8CE6BB7B
	for <util-linux@vger.kernel.org>; Mon, 28 Jan 2013 22:43:08 +0100 (CET)
Received: from mail.collax.com ([127.0.0.1])
	by localhost (mail.collax.com [127.0.0.1]) (amavisd-new, port 10033)
	with ESMTP id 649UrYN718hn for <util-linux@vger.kernel.org>;
	Mon, 28 Jan 2013 22:43:07 +0100 (CET)
Received: from [172.16.1.3] (unknown [172.16.1.3])
	by mail.collax.com (Postfix) with ESMTPSA id D01B8E6BB78
	for <util-linux@vger.kernel.org>; Mon, 28 Jan 2013 22:43:07 +0100 (CET)
Message-ID: <5106F0FB.8020907@collax.com>
Date: Mon, 28 Jan 2013 22:43:23 +0100
From: Andreas Hofmeister <andi@collax.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: output from "blkid" unstable (util-linux 2.22.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,


my "/dev/sdc" is LVM PV and "bkid says so - sometimes:

---8<---
root@ai:~# blkid /dev/sdc
root@ai:~# blkid /dev/sdc
/dev/sdc: UUID=",,," TYPE="LVM2_member"
root@ai:~# blkid /dev/sdc
/dev/sdc: UUID="..." TYPE="LVM2_member"
root@ai:~# blkid /dev/sdc
root@ai:~# blkid /dev/sdc
/dev/sdc: UUID="..." TYPE="LVM2_member"
,,,
--->8---

When looking at "blkid.tab" after each blkid invocation, it seems a 
record for "/dev/sdc" is added and then is removed again.

"blkid" from 2.21 did not have that problem, and a git bisect revealed 
commit 2b29c1bfca6e52c9c1ce2e41fde7967c150c5877 as the culprit.

Reverting that commit made "blkid.tab" and "blkid" output stable.

Ciao
   Andi
