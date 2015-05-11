Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51605 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbbEKKw5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 May 2015 06:52:57 -0400
Date: Mon, 11 May 2015 12:52:55 +0200
From: Karel Zak <kzak@redhat.com>
To: jean-loup.bogalho@clippix.eu
Cc: util-linux@vger.kernel.org, bensberg@justemail.net
Subject: Re: [PATCH v3] fdisk: add the 'i'nfo command
Message-ID: <20150511105255.GN27969@ws.net.home>
References: <20150509211523.GA5207@clippix.lab.lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150509211523.GA5207@clippix.lab.lse.epita.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, May 09, 2015 at 11:15:23PM +0200, Jean-Loup 'clippix' Bogalho wrote:
> This version is modified following the comments of Karel Zak and
> Benno Schuleberg in the review of the previous patch.
> 
>  disk-utils/fdisk-menu.c |  4 ++++
>  disk-utils/fdisk.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  disk-utils/fdisk.h      |  2 ++
>  3 files changed, 50 insertions(+)

 Excellent. Thanks.

 Note, I have added fdisk_label_get_fields_ids_all() to the library to
 provide the output fields independently on output mode. This change
 makes your fdisk code more simple and output more rich.

    Karel


Command (m for help): i
Partition number (1-6, default 6): 1

         Device: /dev/sda1
          Start: 2048
            End: 411647
        Sectors: 409600
           Size: 200M
           Type: EFI System
      Type-UUID: C12A7328-F81F-11D2-BA4B-00A0C93EC93B
           UUID: 2062335E-51B6-49E8-BC3C-4C6D449E6805
           Name: EFI System Partition



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
