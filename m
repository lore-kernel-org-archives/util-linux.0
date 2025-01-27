Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238951FCF74
	for <util-linux@vger.kernel.org>; Mon, 27 Jan 2025 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972648; cv=none; b=sEe0ia4Z4GV1TDzsKbdhINE/HnTX4SZmzzbS1iWn/f05D3CR/ZFkeCS3Vb610x6MHCFgp3/Xv5tCjHEvcoaL5zcnfwvP14qn6pK6VEQSNulftEkmdEaAYLrS4rEcuMnIIp9mei9yXbW2zIqsDhuVg7TdokBSprbj3cpzMQ0Xlek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972648; c=relaxed/simple;
	bh=7dzb3Qj3yv74zh7LzLqeGAi+Es+Kxnu2myFPjGYKnWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0ZKClqvvEEUzmGTByCTBA7TfXTI68zjjNII3tNMx6OR36ChGWCmQYnjMR1KIhaKRZNkp/ay9quTTPVk7P1c7wdt0EoLe4/G5L2yHd3iHpadWsC3SQFBzr3ON21Cs5A+iJb/OhUOW7ii+bhIGI6ULwlqtdQ3LxGabIZsrO0u3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFe/fyeK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFe/fyeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737972644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w8Z862XL7X+Qxs5Jg7pkrPbIT0os34UpDyAvzqpIRLo=;
	b=QFe/fyeKllK2s2M+hUksn6Xc8Czh1phzXHotWwWk6kspLPXb8SShmhO/vm7gapu7pok9ep
	RyozTP3ttbWMrCllNmbnIfIYPnu0jJO594t1uR2gBgBqVWHd7Hv8b38b7qkHze3DFIZKtf
	ajT1X+lXjJ/OactAwU39qq2Zy1vgXdw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-XAigDIMjMYy9BIfVFCe7dw-1; Mon,
 27 Jan 2025 05:10:40 -0500
X-MC-Unique: XAigDIMjMYy9BIfVFCe7dw-1
X-Mimecast-MFC-AGG-ID: XAigDIMjMYy9BIfVFCe7dw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78C3A1801F10;
	Mon, 27 Jan 2025 10:10:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.169])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A0CF1800348;
	Mon, 27 Jan 2025 10:10:37 +0000 (UTC)
Date: Mon, 27 Jan 2025 11:10:34 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: lscpu uses unfitting "MHz" in frequency scaling item
Message-ID: <x7r4hxbdqrn6dk2puidq5aqjj3qtpbk6eyowchked55nh2po23@mgevlbgk6zha>
References: <3a525c3b-ddb1-48c9-887a-f34705415fec@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a525c3b-ddb1-48c9-887a-f34705415fec@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Jan 26, 2025 at 11:52:25AM GMT, Benno Schulenberg wrote:
> Since commit 9b9e4f5d06be55f4b9e1a52b448055933df92c6b
> from four years ago, lscpu lists also an item like this:
> 
>   CPU(s) scaling MHz: 61%
> 
> The printed value is a percentage, not a frequency, so the
> "MHz" should not be there, I think -- the percentage would
> be the same no matter whether the frequencies (in other items)
> are shown in kHz or MHz or GHz.

lscpu only uses MHz (as well as the kernel in /sys), but you are
correct that "CPU(s) frequency scaling" sounds better.

> I would provide a patch, but the message occurs in a dozen
> or more tests.  And probably the column name needs to be
> changed too, from SCALMHZ% to FREQSCAL% or SCALING%?

I am doubtful that we can alter column names. The usual recommendation
is to use "-o <colname>" to obtain output for the script. Changing a
column name would cause a backwardly incompatible modification. It may
be feasible to introduce a column alias, but I am uncertain if it
would be worthwhile.

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

