Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326412AD11
	for <util-linux@vger.kernel.org>; Tue, 23 Apr 2024 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865812; cv=none; b=qeTOb2xGt4v1Szvg9EOYQVjwNTlxwCnN1mS3c8xGXY9sNHvXqbZyXlr2/R5RenL5kZftp2M2ZFcFuOwoScSj3z68r4OEwuwtQLyfTxyFHigMqDPbh00n5U0JFB47jDy7G9f0lBQg/tc8PD5DikPQp0puzXtcxu9GoJ9NJZ2U+L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865812; c=relaxed/simple;
	bh=cDIceqK5UdQ1ft34N+VP9WO2WhPMMjtKg2H1i1ELGV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrYf95SpawjO+lvCId5Ck3Rsk106/pFUr7WF+iTmptDsSFrbnKFMyCiWSyJsK3fDw4tJAB7cpeQaNS3MFSONjP+4rGLPFIYCZwZmWYSo9QNacNvPzZGW3QTBRHQeRuTzXbjqSV8BVsLdcX4Qp7Ft0s26hwPG95KuOaXndPjaoX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTicgq91; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTicgq91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713865809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eyxm3Hne9gfD13W97dO4Io4gUQcyCew/oRTbZVuOJfo=;
	b=QTicgq91ADxZ0gVuS33zFzcxTgtqYP2IuK5hQSMW8qa2NgD5bCCcYbmi+LMEydkSevjt+N
	gCwyzThAIhz3xlrd10FNdHnPB1al4lfpDcQz/GbleZnoZzn4mD6J6txa6KQMD9lowSDJlP
	kxPN+B3fpMtAPogzRDmK9noHEXiCTi0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-rI7Yqns4OsCOPE1zJQra7w-1; Tue, 23 Apr 2024 05:50:05 -0400
X-MC-Unique: rI7Yqns4OsCOPE1zJQra7w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EA688065D2;
	Tue, 23 Apr 2024 09:50:05 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.92])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E274492BC7;
	Tue, 23 Apr 2024 09:50:04 +0000 (UTC)
Date: Tue, 23 Apr 2024 11:50:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Masatake YAMATO <yamato@redhat.com>
Cc: rasmus.villemoes@prevas.dk, util-linux@vger.kernel.org
Subject: Re: [PATCH] flock: add support for using fcntl() with open file
 description locks
Message-ID: <20240423095002.rpxqdoqpra5p3uaw@ws.net.home>
References: <20240417100948.75817-1-rasmus.villemoes@prevas.dk>
 <20240418.023354.1867217317145795622.yamato@redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418.023354.1867217317145795622.yamato@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Thu, Apr 18, 2024 at 02:33:54AM +0900, Masatake YAMATO wrote:
> >  int main(int argc, char *argv[])
> >  {
> >  	struct ul_timer timer;
> > @@ -140,6 +175,7 @@ int main(int argc, char *argv[])
> >  	int no_fork = 0;
> >  	int status;
> >  	int verbose = 0;
> > +	int use_fcntl_ofd = 0;

What about to introduce "lock_method" variable and define

 enum {
    LOCK_BY_FLOCK
    LOCK_BY_FCNTL_OFD
 };

later you can easily extend it by LOCK_BY_FCNTL_POSIX. IMHO the code
will be more readable.

> >  	struct timeval time_start = { 0 }, time_done = { 0 };
> >  	/*
> >  	 * The default exit code for lock conflict or timeout
> > @@ -149,7 +185,8 @@ int main(int argc, char *argv[])
> >  	char **cmd_argv = NULL, *sh_c_argv[4];
> >  	const char *filename = NULL;
> >  	enum {
> > -		OPT_VERBOSE = CHAR_MAX + 1
> > +		OPT_VERBOSE = CHAR_MAX + 1,
> > +		OPT_FCNTL_OFD,
> >  	};
> >  	static const struct option long_options[] = {
> >  		{"shared", no_argument, NULL, 's'},
> > @@ -163,6 +200,7 @@ int main(int argc, char *argv[])
> >  		{"close", no_argument, NULL, 'o'},
> >  		{"no-fork", no_argument, NULL, 'F'},
> >  		{"verbose", no_argument, NULL, OPT_VERBOSE},
> > +		{"fcntl-ofd", no_argument, NULL, OPT_FCNTL_OFD},

I agree that the sort name --fcntl sounds better and it's extendable.

> >  		{"help", no_argument, NULL, 'h'},
> >  		{"version", no_argument, NULL, 'V'},
> >  		{NULL, 0, NULL, 0}
> > @@ -217,6 +255,11 @@ int main(int argc, char *argv[])
> >  			if (conflict_exit_code < 0 || conflict_exit_code > 255)
> >  				errx(EX_USAGE, _("exit code out of range (expected 0 to 255)"));
> >  			break;
> > +#ifdef HAVE_FCNTL_OFD_LOCKS
> > +		case OPT_FCNTL_OFD:
> > +			use_fcntl_ofd = 1;
> > +			break;
> > +#endif
> >  		case OPT_VERBOSE:
> >  			verbose = 1;
> >  			break;
> > @@ -234,6 +277,13 @@ int main(int argc, char *argv[])
> >  		errx(EX_USAGE,
> >  			_("the --no-fork and --close options are incompatible"));
> >  
> > +	/*
> > +	 * For fcntl(F_OFD_SETLK), an exclusive lock requires that the
> > +	 * file is open for write.
> > +	 */
> > +	if (use_fcntl_ofd && type == LOCK_EX)
> > +		open_flags = O_WRONLY;
> > +
> >  	if (argc > optind + 1) {
> >  		/* Run command */
> >  		if (!strcmp(argv[optind + 1], "-c") ||
> > @@ -280,9 +330,15 @@ int main(int argc, char *argv[])
> >  
> >  	if (verbose)
> >  		gettime_monotonic(&time_start);
> > -	while (flock(fd, type | block)) {
> > +	while (use_fcntl_ofd ? do_fcntl_lock(fd, type, block) : flock(fd, type | block)) {

Maybe we can move the locking to a function

    do_lock(fd, method, type, block)

and hide the necessary flock and fcntl details there, instead of
trying to do it in main().

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

