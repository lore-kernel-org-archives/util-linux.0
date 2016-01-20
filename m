Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:55072 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbcATVvx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jan 2016 16:51:53 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 9C352AB12
	for <util-linux@vger.kernel.org>; Wed, 20 Jan 2016 21:51:51 +0000 (UTC)
Subject: Re: [PATCH] libmount: handle btrfs default subvolume mount
To: util-linux@vger.kernel.org
References: <569FEF38.9010102@suse.cz>
Cc: =?UTF-8?B?RGF2aWQgxaB0xJtyYmE=?= <dsterba@suse.cz>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56A00178.9000603@suse.cz>
Date: Wed, 20 Jan 2016 22:51:52 +0100
MIME-Version: 1.0
In-Reply-To: <569FEF38.9010102@suse.cz>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Stanislav Brabec wrote:

 > +#ifndef cpu_to_le64
 > +#if __BYTE_ORDER == __BIG_ENDIAN
 > +#define cpu_to_le64(x) ((__force __le64)(__u64)(bswap_64(x)))
 > +#define le64_to_cpu(x) ((__force __u64)(__le64)(bswap_64(x)))

I just found that my patch does not compile on big endian.
I will send a new patch that uses bitops.h to fix that.

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
