Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:50156 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758792AbbLBQ0a (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Dec 2015 11:26:30 -0500
Subject: Re: [PATCH] fix mount -a on btrfs bind mount
To: Karel Zak <kzak@redhat.com>
References: <56573D53.1020406@suse.cz> <56588FBD.9000502@suse.cz>
 <20151202125117.GJ4955@ws.net.home>
Cc: util-linux <util-linux@vger.kernel.org>, David Sterba <dsterba@suse.cz>,
        =?UTF-8?Q?S=c3=b8ren_Holm?= <sgh@sgh.dk>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <565F1BB4.6040003@suse.cz>
Date: Wed, 2 Dec 2015 17:26:28 +0100
MIME-Version: 1.0
In-Reply-To: <20151202125117.GJ4955@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 2, 2015 at 01:51PM +0100, Karel Zak wrote:
> My bugfix:
>
>   https://github.com/karelzak/util-linux/commit/352740e88e2c9cb180fe845ce210b1c7b5ad88c7
>
> try it :-)
>
If also fixed my problem.

Thanks.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
