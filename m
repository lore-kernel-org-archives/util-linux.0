Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D7242D88
	for <util-linux@vger.kernel.org>; Mon, 15 Sep 2025 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937454; cv=none; b=c7OzGKUZCyuBueb3mErBQuqV9VPNixebgTnSSpSJc9s3vqzd2ARFmQjx1C8B7dACXct3eMUp7w9VpZZH4J62hFGgrGIndV/7GvgEN6k20ZB+GjFU1RPsx03hRhEUJNeZ5afLqY7Q8nVomebhU2au6katEtPy2HPoTrtVkkXp4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937454; c=relaxed/simple;
	bh=9Cf1pfO9/1GomxxsTvAHcE69hVCO1cwRDrYS2IgyDM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/aXzuzy8tsMzbdXPdzWw1199EWxdE67lXRbibPE3PgQv+iwBZhdX0nL2FgMomKisTj2ilSaHDt8een3zA1zpk0hIopzr8npeQCY/lun7UKK5t0urlTYR94ity/ZWOJ+af1FYVVTmWi50Moli0CF/JhmueTTv3ID3CotIugfsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nys0uM6c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nys0uM6c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757937450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ae4/LQoFl/dHOokRhtlJUak4T5IyYSU+js8bY6lBCv0=;
	b=Nys0uM6cdpgOU7+8yqmvZbXAIisBTbRU50cv5Y94IbpDZtGDbnTwLKn64AOZcsGFYloumZ
	2FLq9TnoL80ED/JlEhbc76TaG680Jg/yQ6ysEYsCPXLVIQxw67KtqNkCyBxbIW9M/PAMPd
	p2tWjCeDx/cQdEURixXQHyeu99a6owc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-_y8swLJ5Oi-Ly0nWEtk_aA-1; Mon,
 15 Sep 2025 07:57:24 -0400
X-MC-Unique: _y8swLJ5Oi-Ly0nWEtk_aA-1
X-Mimecast-MFC-AGG-ID: _y8swLJ5Oi-Ly0nWEtk_aA_1757937443
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54D95195394C;
	Mon, 15 Sep 2025 11:57:23 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 623871954126;
	Mon, 15 Sep 2025 11:57:22 +0000 (UTC)
Date: Mon, 15 Sep 2025 13:57:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Richard Aplin <drtune@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Security issue : 2021 commit to libblkid breaks existing string
 sanitization
Message-ID: <3ffdghfdus35xfk6r5tztxfy6f2soyjrg6j6g6d43nf55uwc6f@unu7kambgnbf>
References: <CABL=7+y+5E9N1TRi1o+frURgJExQr6=qSWumc3sz=A5APkuCXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABL=7+y+5E9N1TRi1o+frURgJExQr6=qSWumc3sz=A5APkuCXg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Richard,

-On Fri, Sep 12, 2025 at 06:33:36PM -0700, Richard Aplin wrote:
-> There was a 2021 commit to libblkid,
 > https://github.com/util-linux/util-linux/commit/6db368598962ea8b0329ae148ab878fd458f2533
> commit label "Optimize the blkid_safe_string() function"
> 
> This is potentially an unsafe change and may allow shell command injection.
 
I disagree. :-)

> 1. The shell command blkid has a mode "-o udev" which was designed to
> output information about block devices in a LABEL=VALUE format for
> consumption by shell scripts.

No, it's designed for use in udev rules where nothing is blindly evaluated or executed.

man blkid is pretty explicit:

udev
       print key="value" pairs for easy import into the udev environment; the keys
       are prefixed by ID_FS_ or ID_PART_ prefixes. The value may be modified to be
       safe for udev environment; allowed is plain ASCII, hex-escaping and valid
       UTF-8, everything else (including whitespaces) is replaced with '_'. The keys
       with _ENC postfix use hex-escaping for unsafe chars.

The _ENC variables keep only A-Za-z, "#+-.:=@_" from ASCII; this means
characters like "$()" are escaped.

> I have seen more than one instance (I
> am looking at one now in a commercial product) where userspace script
> has done:
> eval $(blkid -o udev ...)

Well, this is not a blkid issue; you need at least "| grep _ENC".

> 2. One of the fields returned by blkid (e.g. for a USB stick) is the
> volume label, which would be controllable by an attacker inserting a
> USB stick.
> The blkid 'udev' command code is aware of this danger and sanitizes
> the volume label and other attacker-controllable strings by calling
> the function
> blkid_safe_string(...)
> in libblkid.

It is safe for printing to a terminal, not for any random interpreter
like shell. There is also blkid_encode_string() for more restrictive
needs.

> 3. In previous versions of libblkid the blkid_safe_string function
> used to strip several dangerous ascii characters that would have
> allowed command injection (specifically; backtick, parenthesis, etc.
> It still allowed '$' which is a little dubious).

LABEL= and PARTLABEL= are used in config files, rules, etc., so the
goal is to keep them as unmodified as possible. If we introduce
changes in this area, some machines may fail to boot. It's better to
educate system admins not to blindly use "eval" when security matters.


Yes, I understand that users and admins want the installed system to
prevent all their mistakes instantly, but beyond a certain point it
affects usability.

We can add a note to the man page explicitly warning against using
eval $(blkid -o udev ...) to make it clearer for users.

    Karel

