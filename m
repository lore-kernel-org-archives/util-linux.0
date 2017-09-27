Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:51257 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751293AbdI0OuO (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 27 Sep 2017 10:50:14 -0400
Subject: Re: [PATCH] losetup: Add support for logical block size
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>
References: <ea2d1f7c-ca7b-331f-06c6-54e122a74382@suse.cz>
 <20170927115057.avd7knn7qbqheeld@ws.net.home>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <7f98d06d-cc41-d108-e15d-e35c76de017a@suse.cz>
Date: Wed, 27 Sep 2017 16:50:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170927115057.avd7knn7qbqheeld@ws.net.home>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> 
> I'll fix it and ask for review.

a1a4159 looks good and works well. Tested with linux-4.14.0-rc1-3.g6627c5a-default.

/home/sbrabec/VCS/util-linux # ./losetup --logical-blocksize 4096 --find --show ~/cdrom.iso
/dev/loop0
/home/sbrabec/VCS/util-linux # ./losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE       DIO BLOCKSIZE
/dev/loop0         0      0         0  0 /root/cdrom.iso   0      4096
/home/sbrabec/VCS/util-linux # ./losetup -d /dev/loop0
/home/sbrabec/VCS/util-linux # ./losetup --find --show ~/cdrom.iso
/dev/loop0
/home/sbrabec/VCS/util-linux # ./losetup
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE       DIO BLOCKSIZE
/dev/loop0         0      0         0  0 /root/cdrom.iso   0       512
/home/sbrabec/VCS/util-linux # ./losetup --logical-blocksize 4096 /dev/loop0
/home/sbrabec/VCS/util-linux # ./losetup 
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE       DIO BLOCKSIZE
/dev/loop0         0      0         0  0 /root/cdrom.iso   0      4096
/home/sbrabec/VCS/util-linux # ./losetup -d /dev/loop0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
