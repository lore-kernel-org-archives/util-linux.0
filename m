Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756712AbeFSPJm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Jun 2018 11:09:42 -0400
Date: Tue, 19 Jun 2018 17:09:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Milan Broz <gmazyland@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lsblk: add partition table UUID and type fields.
Message-ID: <20180619150939.pljhsypukf6lg6b7@ws.net.home>
References: <20180619103320.13203-1-gmazyland@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180619103320.13203-1-gmazyland@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 19, 2018 at 12:33:20PM +0200, Milan Broz wrote:
> This patch adds PTUUID and PTTYPE fields to lsblk, that are corresponding
> fields to ID_PART_TABLE_UUID and ID_PART_TABLE_TYPE in udev database.

Applied, thanks!

> +	[COL_PTUUID] = { "PTUUID",  36,  0, N_("partition table UUID") },

description change to "partition table identifier (usually UUID)"
because for MBR it is not regular UUID

 # lsblk -s -o +PTTYPE,PTUUID /dev/sdb
 NAME MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT PTTYPE PTUUID
 sdb    8:16   0 74.5G  0 disk            dos    83e7bd0f

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
