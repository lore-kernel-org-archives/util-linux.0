Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:56115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752451AbdEJJyx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 May 2017 05:54:53 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M2cYX-1e0MOd48Jh-00sQg3 for <util-linux@vger.kernel.org>; Wed, 10 May 2017
 11:54:51 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: BUG: wipefs dry run
Date: Wed, 10 May 2017 11:54:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201705101154.50099.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I wonder why wipefs does not show all MBR and GPT signatures which would
be deleted by using "-fa".

$ truncate -s 100M /tmp/CCC
$ ./sfdisk /tmp/CCC <<EOF
> label: gpt
> label-id: 384A8F14-17FF-4782-A190-A5B858E3FCF0
> device: /tmp/CCC
> unit: sectors
> first-lba: 34
> last-lba: 204766
> EOF

$ ./wipefs  -fa --no-act   /tmp/CCC
/tmp/CCC: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 
41 52 54

$ ./wipefs  -fa    /tmp/CCC
/tmp/CCC: 8 bytes were erased at offset 0x00000200 (gpt): 45 46 49 20 50 
41 52 54
/tmp/CCC: 8 bytes were erased at offset 0x063ffe00 (gpt): 45 46 49 20 50 
41 52 54
/tmp/CCC: 2 bytes were erased at offset 0x000001fe (PMBR): 55 aa


cu,
Rudi
