Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48167 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753230Ab1HQMoE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Aug 2011 08:44:04 -0400
Date: Wed, 17 Aug 2011 14:44:00 +0200
From: Karel Zak <kzak@redhat.com>
To: giulioo@pobox.com
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk: trying to create aligned partitions: fail
Message-ID: <20110817124400.GA699@nb.net.home>
References: <20110817061256.BB29DF815@i3.golden.dom> <20110817075613.GB28856@nb.net.home> <20110817093146.860D9F815@i3.golden.dom>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110817093146.860D9F815@i3.golden.dom>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 17, 2011 at 11:31:56AM +0200, Giulio wrote:
> I know sfdisk won't automatically align partitions and didn't expect it to
> do it, my email was about sfdisk behaving in an unexpected way:
> - not respecting 1MB as start of partition when I ask for it
> - creating partitions out of order when using sectors

 Try --in-order command line option, the option is undocumented in old
 versions ;-(

 sfdisk --in-order -L -uM /dev/sdb <<-EOF
 1,10,83
 ,,83
 ;
 ;
 EOF

 result (output from fdisk):
       Device Boot      Start         End      Blocks   Id  System
    /dev/sdb1            2048       22527       10240   83  Linux
    /dev/sdb2           22528      204799       91136   83  Linux



sfdisk --in-order -L -uS /dev/sdb <<-EOF
2048,8000,83
,,83
;
;
EOF

 result (output from fdisk):

       Device Boot      Start         End      Blocks   Id  System
    /dev/sdb1            2048       10047        4000   83  Linux
    /dev/sdb2           10048      204799       97376   83  Linux



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
