Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:44645 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932583AbcBBPES (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Feb 2016 10:04:18 -0500
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
To: Karel Zak <kzak@redhat.com>
References: <569FEF38.9010102@suse.cz> <56A00178.9000603@suse.cz>
 <56A002B3.5090505@suse.cz> <20160121094833.67lg22o4la7j7pto@ws.net.home>
 <56A15487.8020500@suse.cz> <56AA240F.5010900@suse.cz>
 <20160201121811.tk3eqsr5x3w44p34@ws.net.home> <56AF7BE9.4000302@suse.cz>
 <20160202101139.hayiqqbzvseiocdw@ws.net.home>
Cc: util-linux@vger.kernel.org,
        =?UTF-8?B?RGF2aWQgxaB0xJtyYmE=?= <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56B0C570.30804@suse.cz>
Date: Tue, 2 Feb 2016 16:04:16 +0100
MIME-Version: 1.0
In-Reply-To: <20160202101139.hayiqqbzvseiocdw@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Mon, Feb 01, 2016 at 04:38:17PM +0100, Stanislav Brabec wrote:

>> By the way, I am just fixing next btrfs issue. Now it is in blkid. And it
>> seems, that I will need some changes in the code: move the btrfs default
>> subvol function into the public API, and change it to return the subvolid
>> string.
>
> Why we need the function in public API?

Because lsblk does not have access to libmount private functions.

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
