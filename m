Return-Path: arnaud.mouiche@gmail.com
Message-ID: <53A82AF1.3080905@gmail.com>
Date: Mon, 23 Jun 2014 15:26:09 +0200
From: "arnaud.mouiche@gmail.com" <arnaud.mouiche@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH] mkfs.cramfs: fix potential uid, gid or mode drop.
References: <1403036214-13067-1-git-send-email-arnaud.mouiche@gmail.com> <20140623111619.GJ25885@x2.net.home>
In-Reply-To: <20140623111619.GJ25885@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <util-linux.vger.kernel.org>

Le 23/06/2014 13:16, Karel Zak a écrit :
> On Tue, Jun 17, 2014 at 10:16:54PM +0200, arnaud.mouiche@gmail.com wrote:
>> From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
>>
>> find_identical_file() may squash files with identical contents, but
>> different uid/gid or mode.
>>
>> here is a test script to show the problem (to run as root):
>> without this patch, the output is
>>
>>    -rw-r--r-- 1 root root 4 janv.  1  1970 a
>>    -rw-r--r-- 1 root root 4 janv.  1  1970 b
>>    -rw-r--r-- 1 root root 4 janv.  1  1970 c
>>
>> whereas the expected result should be
>>
>>    -rw-r--r-- 1 root   root 4 janv.  1  1970 a
>>    -rw------- 1 root   root 4 janv.  1  1970 b
>>    -rw-r--r-- 1 daemon root 4 janv.  1  1970 c
>   Strange.
>
>> -	if (orig->size == new->size && orig->path) {
>> +	if (orig->size == new->size &&
>> +		orig->uid == new->uid &&
>> +		orig->gid == new->gid &&
>> +		orig->mode == new->mode &&
>> +		orig->path) {
>>   		if (!orig->flags)
>>   			mdfile(orig);
>>   		if (!new->flags)
>   I don't think this is right solution. The content de-duplication code
>   has to be independent on file name, uid/gid and mode. The
>   de-duplication does not mean that info about the file has been
>   removed from the cramfs image.
>   
>   The filesystem still contains file specific inode. So if you see a
>   different filename then you have to see a different uid/gid too.
>   (I guess.)
>
>
>      Karel
You are right,
The issue is in the linux kernel code indeed (fs/cramfs/inode.c)
on line 37
     /* These two macros may change in future, to provide better st_ino
        semantics. */
     #define CRAMINO(x)    (((x)->offset && (x)->size)?(x)->offset<<2:1)
     #define OFFSET(x)    ((x)->i_ino)


for linux, the inode of an entry is equal to the data offset.
2 files which have been squashed through the "eliminate_doubles" process 
(mkfs.cramfs) have identical inode number under linux,
whatever the mode, uid or gid is.

so forget about my patch, I need for find a patch for the FS mainling list

Arnaud
>
