Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA75487BE
	for <util-linux@vger.kernel.org>; Wed, 19 Mar 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393472; cv=none; b=NvpDAI11Wy0ou2sjzDrSoUyg03QdeCciFoGFB8XUClbDHA4O994ihaibduxw79uaNwMPJEGCYR1JLQFCR0tUekhhUN1SxCe3ZCpGqqHEOPOZG8Oegtg2KKbAlNZfRbfgUZqebd8mkpahM1p0Yj3yV2scpY2uEBtXF598NdLqzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393472; c=relaxed/simple;
	bh=tjHaI6IpSTnz9+7TTGlwEoiq2IgP1aqNphILF75sHTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XilHMT+B46+4Ypf/pW/OPx8GPidG1mH7jD9vVLeAWD08LpdSWz3a8NjveHtcNeeOqRusJp9H0NpQLmKQW5EeTpWQvf29I0l8O1CeoOTsu7i1t68rZ/8w8Ywkl08MmAVB3w5LsinD7IkjtXWaztl5tTe4/26ADBUTqXfAagEkgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehzZWZ1+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehzZWZ1+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742393468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeLadGQOECXLt0M6UGnEuf14Xk2iqTyR2m3Kck8WpcA=;
	b=ehzZWZ1+R/jXmbGiwkzNw6LYE3ZPAKLLRGq1HqrwPcXkQk1tqvtB+HuZZKoWI/QcbDBW4s
	HF8YtnJ/NEpyF3eABbiEtDNFxPbiyJs9KdDQgXi/DRODffPaVfOYiHJObRIjcRL72c50Tv
	o7TNz1NrwqZBfy3IisSfUJ4J57d2lzw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-iOYYUwiPNeGZfQDIA0MtjA-1; Wed,
 19 Mar 2025 10:11:05 -0400
X-MC-Unique: iOYYUwiPNeGZfQDIA0MtjA-1
X-Mimecast-MFC-AGG-ID: iOYYUwiPNeGZfQDIA0MtjA_1742393464
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11F7C1800267;
	Wed, 19 Mar 2025 14:11:04 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.181])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FC94180094A;
	Wed, 19 Mar 2025 14:11:02 +0000 (UTC)
Date: Wed, 19 Mar 2025 15:10:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] more: ensure that on larger terminals 'h' shows only the
 in-app help text
Message-ID: <xecv6hdqkiyaaoudwlyvnxpqpyjbrqfueoe53f5euorvoefyg6@zgt43jzq6tqj>
References: <20250318110108.5086-1-bensberg@telfort.nl>
 <ev7vif5l3j45bcw7td4w4qehujwnrj7n2leg2y4324k4mrive5@fhd7i3wyezwg>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ev7vif5l3j45bcw7td4w4qehujwnrj7n2leg2y4324k4mrive5@fhd7i3wyezwg>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Mar 19, 2025 at 02:32:28PM +0100, Karel Zak wrote:
> On Tue, Mar 18, 2025 at 12:01:08PM +0100, Benno Schulenberg wrote:
> > When a terminal has more than 24 rows, the rows above the help text
> > (shown by typing 'h' or '?') were still those of the displayed file.
> > That could make it hard to notice that the two lines above the first
> > row of dashes belonged to the help text, not to the displayed file.
> 
> This is a misunderstanding. By default, more(1) is in scroll mode, and
> the help output is added to the display. Therefore, it is expected
> that you see data from the file as well as the help text. You need to
> use -c or -p to clear the screen before it prints the help text.

Note that I agree the output is not very readable, and it would be
better to start the entire help output with a separator, something
like:

diff --git a/text-utils/more.c b/text-utils/more.c
index a035591af..92b257046 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1545,6 +1545,7 @@ static char *find_editor(void)
 
 static void runtime_usage(void)
 {
+	print_separator('-', 79);
 	fputs(_("Most commands optionally preceded by integer argument k.  "
 		"Defaults in brackets.\n"
 		"Star (*) indicates argument becomes new default.\n"), stdout);


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

