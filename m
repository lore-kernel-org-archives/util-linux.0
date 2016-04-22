Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH 0/3] btrfs-safe implementation of -oloop
To: Karel Zak <kzak@redhat.com>
References: <570D3CC7.5060809@suse.cz>
 <20160422112255.idrjikem5u253kh6@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <571A1C21.3020602@suse.cz>
Date: Fri, 22 Apr 2016 14:42:09 +0200
MIME-Version: 1.0
In-Reply-To: <20160422112255.idrjikem5u253kh6@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

>> - If the same backing file is already used for a loop device with
>>    correct offset, but incorrect sizelimit, there is no solution. The
>>    current implementation does not check for it.
>
>   We need a warning/error for this.
>
I am working on an improved, more safe loop checks.

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
