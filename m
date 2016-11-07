Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:38364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932278AbcKGNOB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Nov 2016 08:14:01 -0500
Subject: Re: [PATCH 2/3] tests: replace sleep by udevadm
To: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
 <1478358489-18103-2-git-send-email-sweet_f_a@gmx.de>
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <9da30f96-860e-0bd4-4efc-19fe6f0c4b7e@suse.cz>
Date: Mon, 7 Nov 2016 14:13:59 +0100
MIME-Version: 1.0
In-Reply-To: <1478358489-18103-2-git-send-email-sweet_f_a@gmx.de>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Ruediger Meier wrotek:
> From: Ruediger Meier <ruediger.meier@ga-group.nl>
>
> -sleep 3
> +udevadm settle

Thanks for the research. I was not aware that the race comes from udev.

Do you think that it would make sense to add udevadm settle directly to 
losetup?

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
