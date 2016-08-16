Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:36952 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbcHPRot (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Aug 2016 13:44:49 -0400
Subject: Re: nfs/cifs mountinfo differences
To: =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>
References: <91d465d3-4f5b-6270-a6c5-38bd94695731@suse.cz>
 <5eb96b3e-d463-bf11-49de-f614247d6b29@suse.cz>
 <20160805192234.2c9d5b7d@aaptelpc>
Cc: util-linux <util-linux@vger.kernel.org>, linux-cifs@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <7c2181d1-c7b5-df04-0640-ec23f5d78eab@suse.cz>
Date: Tue, 16 Aug 2016 19:44:47 +0200
MIME-Version: 1.0
In-Reply-To: <20160805192234.2c9d5b7d@aaptelpc>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Aurélien Aptel wrote on Aug 5, 2016 at 7:22 PM:
> Now correct me if I'm wrong (I really am not sure) but I think 'mount
> -a' assumes only bind-mounts should print a subdir path instead of "/".

Yes. It is the only indication that the mountinfo line describes a bind 
mount.

> or (B) we consider the current kernel doc as the Truth:
>
> - we make NFS do like CIFS
> - leave CIFS unchanged [1]
> - figure out what to do with mount utility (back to initial problem I
>   guess)

The proposed patch does the thing.

> Personal opinion: the way the current doc is written and again, the fact
> that linux lets you override the path on a per-filesystem basis makes me
> think solution B is the way to go.
>
> Also, I don't understand why
>
>
> We can't we compare in this case? Isn't it just a matter of
> concatenating the source with the subdir?

Well, it looks possible. The path component 1 is always the server name, 
2 volume name, and the rest is path.

So cut components 3 and up, and remove it from the leading part of 4th 
column. Then you will have a part that can be used for bind mount 
processing.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
