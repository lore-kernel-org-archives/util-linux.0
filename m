Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0416D9A7
	for <util-linux@vger.kernel.org>; Tue, 18 Jun 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718707121; cv=none; b=BK3/Y+Ni/Ck+NqibMLPJMFHEh34cpBFRKI5+QHNSWWVWquvoCXQj4Cbr4KNqwCY/Vy1e2IMQ/XKuxQ5Qjjy5f5puwB0wOCa9uazs2iC0RH1UFmoCj/YgxrhCF5qsvCM6Uwcyz4wxwroR/yf3mgi+59cc+SZlnnYWL3Nc7cGoiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718707121; c=relaxed/simple;
	bh=9piReTy1XAadAaam/L4GLRZ0/tv8MTVlMAYePnV/TJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1DrW18A+aq6aeCAPg/Wrvyx/kF7Ypl4AyhbEAXeuFE9lGLHH88ZDEqu9GPCswMc4PDgjwpktkSNHSWKNJUQXJtpRI1Es3XWtLgfG6fEc9zkVXk+TomSD0dNMCrpccUEg62E6osGWc/JJHJpurxmWNWZ1P2rSooCJqmzSsoU++Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu; spf=pass smtp.mailfrom=vivier.eu; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivier.eu
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MTAS1-1rwdub3Qo3-00J7gT; Tue, 18 Jun 2024 12:13:50 +0200
Message-ID: <e875d06e-a0c5-47c3-b368-06f398e676ab@vivier.eu>
Date: Tue, 18 Jun 2024 12:13:50 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] unshare: load binfmt_misc interpreter
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20240611084314.183913-1-laurent@vivier.eu>
 <20240611084314.183913-3-laurent@vivier.eu>
 <20240618095151.2vidavjn47xgbxf4@ws.net.home>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20240618095151.2vidavjn47xgbxf4@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gNslqmV84N3y2rwOXY6UfA/tDWCj8SeemJpCWmku4GFUnPwbCYV
 4fp+rke0uYLUbwX4QdP0DGKeLbLK7XKaIkSNSHPI20YvcNQsWwKVMmDQD/rOfr6HcOTwG8m
 XC6EIc3wdabvqa3Lsn41wsWLq/3pYblHeLkwTAckxtXsrtiRTlRbKNFqJqpvQFlpexfMLvd
 jc780DUhQKH8rvk/o+lVg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KmxRntSPJAM=;hst2boxyt3NzWP1KXoNcEQEF77K
 ivRghEasOIzeLXs5rHPjXYl9B2Gmcna5hAQ4GnCwBRaFmK6YWzhy4KlkoxK+RfeXXhCjJPhIj
 esBN+f3vgKJywo7TfKLqphO1I8TIm15lsMwrzJG7vM6yALMwgvua19Jo3uubIouk2X8H6jDuv
 hOLXIwVh5BRRcUA1YFoy/5fCcAgCtp69B0khUADnWNst0UnApiCpTvh0ZLrmg+n5PVAKNQgCV
 zVrzUE4yYED+xcnxWignXhDX8kGBPhFbbs2MQBEC6fv4hn+jY5tFQ8AJeT4+uZZkmaN3gsE4S
 KXZ1ZKtkcL0Hkzo0fDJ+BSLwHnvhyEZsDG8Icee+qkjqnjhQCxi9tTcatWaiB2iknJEMxiqNt
 KWdf4G8aRbLuwvO2bEn6nwQwsjeFG4LXLsEkvV3c4wQeox1EqwIUFtOo1HrEIzo03k9qr6y50
 3br/VZJituidwIboBfozOUItsxcgXgm9fs6YFBc8nxq3Zr0J3kifsz1uOrGVGDIRQoZdqu4NM
 +tXGNNB5LvHaPpAxOwLYsQrdK6fBb9SJTNii/SmsT1e8Wd3yrlqJlAnDxIIxPtmDwzJhYQcUY
 GAXzoDnOUiUqU+i9ViqESJKsIctSiUHd5TSrxenXcxgf3NmgbY9CnnZNUik91BxdGSKmQ+OgA
 LeAUQ7ckVXbW5MFNsr/kp0yCgHsuEMvHM0J0eYJoZEe4EsaFEa8+NcTkUZLuKopnw6YL9jsjl
 EThkoufDDk3FK/tLCI+10Q/PDHYl4/3vbF6DubaAEe2Rmb+3bPTGqY=

Le 18/06/2024 à 11:51, Karel Zak a écrit :
> 
>   Hi Laurent,
> 

Hi Karel,

> On Tue, Jun 11, 2024 at 10:43:14AM +0200, Laurent Vivier wrote:
>> +*-l*, **--load-interp=**__file__::
>> +Load binfmt_misc definition in the namespace (implies *--mount-binfmt*).
> 
> Is it actually a file, or does the argument have a more complex
> format? If there is something more that it should be described here.
> It fine describe in the man page more about the interpreters.

Your right the format here is not actually a file, but it defines how to use the file provided in 
the parameter as an interpreter.

We provide here what we will write in /proc/sys/fs/binfmt_misc/register and the format is described 
in https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst:

"To actually register a new binary type, you have to set up a string looking like 
``:name:type:offset:magic:mask:interpreter:flags``
[...]
- ``name``
    is an identifier string. A new /proc file will be created with this
    name below ``/proc/sys/fs/binfmt_misc``
- ``type``
    is the type of recognition. Give ``M`` for magic and ``E`` for extension.
- ``offset``
    is the offset of the magic/mask in the file
- ``magic``
    is the byte sequence binfmt_misc is matching for.
- ``mask``
    is an (optional, defaults to all 0xff) mask.
- ``interpreter``
    is the program that should be invoked with the binary as first
    argument
- ``flags``
    is an optional field that controls several aspects of the invocation
    of the interpreter.
    ``P`` - preserve-argv[0]
             Legacy behavior of binfmt_misc is to overwrite
             the original argv[0] with the full path to the binary. When this
             flag is included, binfmt_misc will add an argument to the argument
             vector for this purpose, thus preserving the original ``argv[0]``.
     ``O`` - open-binary
	    Legacy behavior of binfmt_misc is to pass the full path
             of the binary to the interpreter as an argument. When this flag is
             included, binfmt_misc will open the file for reading and pass its
             descriptor as an argument
     ``C`` - credentials
             Currently, the behavior of binfmt_misc is to calculate
             the credentials and security token of the new process according to
             the interpreter. When this flag is included, these attributes are
             calculated according to the binary
``F`` - fix binary
             The usual behaviour of binfmt_misc is to spawn the
	    binary lazily when the misc format file is invoked.  However,
	    this doesn't work very well in the face of mount namespaces and
	    changeroots, so the ``F`` mode opens the binary as soon as the
	    emulation is installed and uses the opened image to spawn the
	    emulator"
> 
>> +
>>   *--monotonic* _offset_::
>>   Set the offset of *CLOCK_MONOTONIC* which will be used in the entered time namespace. This option requires unsharing a time namespace with *--time*.
>>   
>> @@ -256,6 +259,13 @@ up 21 hours, 30 minutes
>>   up 9 years, 28 weeks, 1 day, 2 hours, 50 minutes
>>   ....
>>   
>> +The following example execute a chroot into the directory /chroot/powerpc/jessie and install the interpreter /bin/qemu-ppc-static to execute the powerpc binaries.
>> +If the interpreter is defined with the flag F, the interpreter is loaded before the chroot otherwise the interpreter is loaded from inside the chroot.
>> +
>> +....
>> +$  unshare --map-root-user --fork --pid --load-interp=":qemu-ppc:M::\\x7fELF\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x14:\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\x00\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/bin/qemu-ppc-static:OCF" --root=/chroot/powerpc/jessie /bin/bash -l
>> +....
> 
> As an uneducated reader, I am confused by the flags. Where is the 'F'
> flag? Perhaps you could provide more explanation to make it easier for
> readers to understand.

I think this option should be used by educated user that is aware of binfmt_misc format.

Do you want I copy a part of the binfmt_misc documentation in the unshare documentation?

> 
>>   == AUTHORS
>>   
>>   mailto:dottedmag@dottedmag.net[Mikhail Gusarov],
>> diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
>> index d79aa1125955..f8e1141840ca 100644
>> --- a/sys-utils/unshare.c
>> +++ b/sys-utils/unshare.c
>> @@ -725,6 +725,35 @@ static pid_t map_ids_from_child(int *fd, uid_t mapuser,
>>   	exit(EXIT_SUCCESS);
>>   }
>>   
>> +static int is_fixed(const char *interp)
>> +{
>> +	const char *flags;
>> +
>> +	flags = strrchr(interp, ':');
>> +
>> +	return strchr(flags, 'F') != NULL;
>> +}
>> +
>> +static void load_interp(const char *binfmt_mnt, const char *interp)
>> +{
>> +	int dirfd, fd;
>> +
>> +	dirfd = open(binfmt_mnt, O_PATH | O_DIRECTORY);
>> +	if (dirfd < 0)
>> +		err(EXIT_FAILURE, _("cannot open %s"), binfmt_mnt);
>> +
>> +	fd = openat(dirfd, "register", O_WRONLY);
>> +	if (fd < 0)
>> +		err(EXIT_FAILURE, _("cannot open %s/register"), binfmt_mnt);
>> +
>> +	if (write_all(fd, interp, strlen(interp)))
>> +		err(EXIT_FAILURE, _("write failed %s/register"), binfmt_mnt);
>> +
>> +	close(fd);
>> +
>> +	close(dirfd);
>> +}
>> +
>>   static void __attribute__((__noreturn__)) usage(void)
>>   {
>>   	FILE *out = stdout;
>> @@ -772,6 +801,7 @@ static void __attribute__((__noreturn__)) usage(void)
>>   	fputs(_(" -G, --setgid <gid>        set gid in entered namespace\n"), out);
>>   	fputs(_(" --monotonic <offset>      set clock monotonic offset (seconds) in time namespaces\n"), out);
>>   	fputs(_(" --boottime <offset>       set clock boottime offset (seconds) in time namespaces\n"), out);
>> +	fputs(_(" -l, --load-interp <file>  load binfmt definition in the namespace (implies --mount-binfmt)\n"), out);
>>   
>>   	fputs(USAGE_SEPARATOR, out);
>>   	fprintf(out, USAGE_HELP_OPTIONS(27));
>> @@ -830,6 +860,7 @@ int main(int argc, char *argv[])
>>   		{ "wd",		   required_argument, NULL, 'w'		    },
>>   		{ "monotonic",     required_argument, NULL, OPT_MONOTONIC   },
>>   		{ "boottime",      required_argument, NULL, OPT_BOOTTIME    },
>> +		{ "load-interp",   required_argument, NULL, 'l'		    },
>>   		{ NULL, 0, NULL, 0 }
>>   	};
>>   
>> @@ -846,6 +877,7 @@ int main(int argc, char *argv[])
>>   	const char *newroot = NULL;
>>   	const char *newdir = NULL;
>>   	pid_t pid_bind = 0, pid_idmap = 0;
>> +	const char *newinterp = NULL;
>>   	pid_t pid = 0;
>>   #ifdef UL_HAVE_PIDFD
>>   	int fd_parent_pid = -1;
>> @@ -868,7 +900,7 @@ int main(int argc, char *argv[])
>>   	textdomain(PACKAGE);
>>   	close_stdout_atexit();
>>   
>> -	while ((c = getopt_long(argc, argv, "+fhVmuinpCTUrR:w:S:G:c", longopts, NULL)) != -1) {
>> +	while ((c = getopt_long(argc, argv, "+fhVmuinpCTUrR:w:S:G:cl:", longopts, NULL)) != -1) {
>>   		switch (c) {
>>   		case 'f':
>>   			forkit = 1;
>> @@ -1011,6 +1043,15 @@ int main(int argc, char *argv[])
>>   			boottime = strtos64_or_err(optarg, _("failed to parse boottime offset"));
>>   			force_boottime = 1;
>>   			break;
>> +		case 'l':
>> +			unshare_flags |= CLONE_NEWNS | CLONE_NEWUSER;
>> +			if (!binfmt_mnt) {
>> +				if (!procmnt)
>> +					procmnt = "/proc";
>> +				binfmt_mnt = _PATH_PROC_BINFMT_MISC;
>> +			}
>> +			newinterp = optarg;
>> +			break;
>>   
>>   		case 'h':
>>   			usage();
>> @@ -1165,6 +1206,13 @@ int main(int argc, char *argv[])
>>   	if ((unshare_flags & CLONE_NEWNS) && propagation)
>>   		set_propagation(propagation);
>>   
>> +	if (newinterp && is_fixed(newinterp)) {
>> +		if (mount("binfmt_misc", _PATH_PROC_BINFMT_MISC, "binfmt_misc",
>> +			  MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0)
>> +			err(EXIT_FAILURE, _("mount %s failed"), _PATH_PROC_BINFMT_MISC);
>> +		load_interp(_PATH_PROC_BINFMT_MISC, newinterp);
>> +	}
> 
> If I understand correctly, using --load-interp with 'F' calls
> mount(binfmt_misc) twice:
> 
> 1) before chroot
> 2) after chroot() and after mount(/proc) (implies --mount-binfmt and
>     --mount-proc too)

Yes, it's needed before chroot to load the interpreter from the caller filesystem.
it's not needed after the chroot in this case, it's only there for consistency to have it in the 
chroot as we asked it on the command line. I think it can be removed if you prefer.
> 
> I believe it would be helpful to include this information in the man
> page.

I'll update the man page accordingly.

Thanks,
Laurent
>      Karel
> 

