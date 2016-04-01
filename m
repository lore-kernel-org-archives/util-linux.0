Return-Path: sbrabec@suse.cz
Subject: Re: [PATCH] Fix possible NULL dereference in get_btrfs_fs_root()
To: Karel Zak <kzak@redhat.com>
References: <56FC3BE7.7040001@suse.cz>
 <20160331095433.kt6skftq5agqrxje@ws.net.home>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56FE7ECD.2040804@suse.cz>
Date: Fri, 1 Apr 2016 15:59:41 +0200
MIME-Version: 1.0
In-Reply-To: <20160331095433.kt6skftq5agqrxje@ws.net.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <util-linux.vger.kernel.org>

On Mar 31, 2016 at 11:54 Karel Zak wrote:
> On Wed, Mar 30, 2016 at 10:49:43PM +0200, Stanislav Brabec wrote:
>> set_fs_root() got it as upd->mountinfo being NULL from utab_new_entry(). That
>> got it from mnt_update_set_fs(), that from mnt_context_prepare_update() (where
>> it is cxt->update->mountinfo).
>>
>> At least the constructor mnt_new_update() can create context with cxt->update
>> being not NULL and cxt->update->mountinfo being NULL.
>>
>> It is also possible to pass to mnt_context_prepare_update() with cxt->update not
>> being NULL but cxt->update->mountinfo being NULL created by mnt_new_context(),
>> e. g. from mnt_context_mount().
>
> It's seems better to read mountinfo when really necessary than always.
> I have applied something else:
>
> https://github.com/karelzak/util-linux/commit/e9cd2e2bd9ec91a0b1050c4aa79555d142985924

I just got a positive feedback. My original patch as well as your patch
fix the crash.

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
