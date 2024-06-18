Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3E91AC77D
	for <util-linux@vger.kernel.org>; Tue, 18 Jun 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704323; cv=none; b=JkLN43iepZb+Af1YgKZ4oeoJWj36SpZVaOKVJTRb5uNMUVmZyyVgBsdKUceYXxyFDwzViJadEulYPEoB3IGugXFajMvkorFj8V0pa0QbktIANM931CRw6aBUkheqmFom/su7hHxgA2kZrBSIDmDj/keCEQ2ePbQsi/rxf/Hjffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704323; c=relaxed/simple;
	bh=LYJxUUnrbk6MGzwy1638wbb+HbhGINDtyXrLM2nAFzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FP2wk/tjrn+z6Jr5AHMV9J0QmJ9UZIBkzE5EQj3yGRM+V1VE/PKAfufen9kVBXqJC6zERTO45bdDEhKTfoiEIrh0NiZTsAmr2Q8pTk5MJ5rnPYlKMNfaemuHg8+IafOLMRod9jrsr8zhCqm02JmeqnYGo0e7C407qR6zMUbxUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGF18Hpe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGF18Hpe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718704320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D3BQwaMB11R4XPvBD0gmFbDGFZnNmP0HW3g1KOiRwj4=;
	b=cGF18HpeIxvnqkR9R2xRJQIldChDv2yKXdhWsLUpg816g0WAWk0km+RHn6pm5xGVD+D6mg
	JIy0tRRYQX4RTY5z9tg4oclsVNU5BqMJDdmlPDCF5grFdoNcNzaql0d21jbQBGLmmMjwFq
	x2rRVUQ1Vbvz8tJoTOnZ3sBUso+NsRQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-BZ6y94QfMbOFyYEsxX5Nww-1; Tue,
 18 Jun 2024 05:51:56 -0400
X-MC-Unique: BZ6y94QfMbOFyYEsxX5Nww-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6BEC19560B5;
	Tue, 18 Jun 2024 09:51:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2F6A3000218;
	Tue, 18 Jun 2024 09:51:54 +0000 (UTC)
Date: Tue, 18 Jun 2024 11:51:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] unshare: load binfmt_misc interpreter
Message-ID: <20240618095151.2vidavjn47xgbxf4@ws.net.home>
References: <20240611084314.183913-1-laurent@vivier.eu>
 <20240611084314.183913-3-laurent@vivier.eu>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611084314.183913-3-laurent@vivier.eu>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


 Hi Laurent,

On Tue, Jun 11, 2024 at 10:43:14AM +0200, Laurent Vivier wrote:
> +*-l*, **--load-interp=**__file__::
> +Load binfmt_misc definition in the namespace (implies *--mount-binfmt*).

Is it actually a file, or does the argument have a more complex
format? If there is something more that it should be described here.
It fine describe in the man page more about the interpreters.

> +
>  *--monotonic* _offset_::
>  Set the offset of *CLOCK_MONOTONIC* which will be used in the entered time namespace. This option requires unsharing a time namespace with *--time*.
>  
> @@ -256,6 +259,13 @@ up 21 hours, 30 minutes
>  up 9 years, 28 weeks, 1 day, 2 hours, 50 minutes
>  ....
>  
> +The following example execute a chroot into the directory /chroot/powerpc/jessie and install the interpreter /bin/qemu-ppc-static to execute the powerpc binaries.
> +If the interpreter is defined with the flag F, the interpreter is loaded before the chroot otherwise the interpreter is loaded from inside the chroot.
> +
> +....
> +$  unshare --map-root-user --fork --pid --load-interp=":qemu-ppc:M::\\x7fELF\x01\\x02\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x02\\x00\\x14:\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\x00\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xff\\xfe\\xff\\xff:/bin/qemu-ppc-static:OCF" --root=/chroot/powerpc/jessie /bin/bash -l
> +....

As an uneducated reader, I am confused by the flags. Where is the 'F'
flag? Perhaps you could provide more explanation to make it easier for
readers to understand.

>  == AUTHORS
>  
>  mailto:dottedmag@dottedmag.net[Mikhail Gusarov],
> diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
> index d79aa1125955..f8e1141840ca 100644
> --- a/sys-utils/unshare.c
> +++ b/sys-utils/unshare.c
> @@ -725,6 +725,35 @@ static pid_t map_ids_from_child(int *fd, uid_t mapuser,
>  	exit(EXIT_SUCCESS);
>  }
>  
> +static int is_fixed(const char *interp)
> +{
> +	const char *flags;
> +
> +	flags = strrchr(interp, ':');
> +
> +	return strchr(flags, 'F') != NULL;
> +}
> +
> +static void load_interp(const char *binfmt_mnt, const char *interp)
> +{
> +	int dirfd, fd;
> +
> +	dirfd = open(binfmt_mnt, O_PATH | O_DIRECTORY);
> +	if (dirfd < 0)
> +		err(EXIT_FAILURE, _("cannot open %s"), binfmt_mnt);
> +
> +	fd = openat(dirfd, "register", O_WRONLY);
> +	if (fd < 0)
> +		err(EXIT_FAILURE, _("cannot open %s/register"), binfmt_mnt);
> +
> +	if (write_all(fd, interp, strlen(interp)))
> +		err(EXIT_FAILURE, _("write failed %s/register"), binfmt_mnt);
> +
> +	close(fd);
> +
> +	close(dirfd);
> +}
> +
>  static void __attribute__((__noreturn__)) usage(void)
>  {
>  	FILE *out = stdout;
> @@ -772,6 +801,7 @@ static void __attribute__((__noreturn__)) usage(void)
>  	fputs(_(" -G, --setgid <gid>        set gid in entered namespace\n"), out);
>  	fputs(_(" --monotonic <offset>      set clock monotonic offset (seconds) in time namespaces\n"), out);
>  	fputs(_(" --boottime <offset>       set clock boottime offset (seconds) in time namespaces\n"), out);
> +	fputs(_(" -l, --load-interp <file>  load binfmt definition in the namespace (implies --mount-binfmt)\n"), out);
>  
>  	fputs(USAGE_SEPARATOR, out);
>  	fprintf(out, USAGE_HELP_OPTIONS(27));
> @@ -830,6 +860,7 @@ int main(int argc, char *argv[])
>  		{ "wd",		   required_argument, NULL, 'w'		    },
>  		{ "monotonic",     required_argument, NULL, OPT_MONOTONIC   },
>  		{ "boottime",      required_argument, NULL, OPT_BOOTTIME    },
> +		{ "load-interp",   required_argument, NULL, 'l'		    },
>  		{ NULL, 0, NULL, 0 }
>  	};
>  
> @@ -846,6 +877,7 @@ int main(int argc, char *argv[])
>  	const char *newroot = NULL;
>  	const char *newdir = NULL;
>  	pid_t pid_bind = 0, pid_idmap = 0;
> +	const char *newinterp = NULL;
>  	pid_t pid = 0;
>  #ifdef UL_HAVE_PIDFD
>  	int fd_parent_pid = -1;
> @@ -868,7 +900,7 @@ int main(int argc, char *argv[])
>  	textdomain(PACKAGE);
>  	close_stdout_atexit();
>  
> -	while ((c = getopt_long(argc, argv, "+fhVmuinpCTUrR:w:S:G:c", longopts, NULL)) != -1) {
> +	while ((c = getopt_long(argc, argv, "+fhVmuinpCTUrR:w:S:G:cl:", longopts, NULL)) != -1) {
>  		switch (c) {
>  		case 'f':
>  			forkit = 1;
> @@ -1011,6 +1043,15 @@ int main(int argc, char *argv[])
>  			boottime = strtos64_or_err(optarg, _("failed to parse boottime offset"));
>  			force_boottime = 1;
>  			break;
> +		case 'l':
> +			unshare_flags |= CLONE_NEWNS | CLONE_NEWUSER;
> +			if (!binfmt_mnt) {
> +				if (!procmnt)
> +					procmnt = "/proc";
> +				binfmt_mnt = _PATH_PROC_BINFMT_MISC;
> +			}
> +			newinterp = optarg;
> +			break;
>  
>  		case 'h':
>  			usage();
> @@ -1165,6 +1206,13 @@ int main(int argc, char *argv[])
>  	if ((unshare_flags & CLONE_NEWNS) && propagation)
>  		set_propagation(propagation);
>  
> +	if (newinterp && is_fixed(newinterp)) {
> +		if (mount("binfmt_misc", _PATH_PROC_BINFMT_MISC, "binfmt_misc",
> +			  MS_NOSUID|MS_NOEXEC|MS_NODEV, NULL) != 0)
> +			err(EXIT_FAILURE, _("mount %s failed"), _PATH_PROC_BINFMT_MISC);
> +		load_interp(_PATH_PROC_BINFMT_MISC, newinterp);
> +	}

If I understand correctly, using --load-interp with 'F' calls
mount(binfmt_misc) twice:

1) before chroot
2) after chroot() and after mount(/proc) (implies --mount-binfmt and
   --mount-proc too)

I believe it would be helpful to include this information in the man
page.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

