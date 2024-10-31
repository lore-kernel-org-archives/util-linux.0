Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E68F17B418
	for <util-linux@vger.kernel.org>; Thu, 31 Oct 2024 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364713; cv=none; b=Dj9xDGEUpbyuSMGfXGKw4BO9ZdmlS4bHFCxqz8hd1gZu6X72VPIFHpCRmvIej4H68QCcgUTjVaF+JRMSWSO3ZaC/+f/Fk2Zk0iPehceb3SifNyi9+oGPLBaV78X7V21BbemtNgOR8xkxap2eK+qOWzbLkRTG5RaxCCUqQQMF81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364713; c=relaxed/simple;
	bh=O6Tjz3yMxGUaQLovPWAuh2DrdGs1fWhq1VlUkVwr4h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzjS4ekQB3S8KFxqaRbtHCw0rtZLfo8pCREYZjC9TrKWAwIZ7C/2Ux3fnIXRCKk5iiQy2W1hEQiOaUPdMcSL/sWfA+rtkZn/nQowXA1t1QE1/FgCNKQYcOt4LAjQjzU+j91GxGfAX1/SZ84FmYccN3qXpTRBJikUL1INEpIYrFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHbmWvi/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHbmWvi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730364709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R9/sc1y4fFTjclrjicdp0NpaqX4ouySvqiaqRg9qoQQ=;
	b=hHbmWvi/8YOC3GuSc1OF+91/JE/RAMpRrm1A0F+o2qZ9XatHULYWx+cm3v0smmiXHHvldP
	0yqd3xu5ZWg1wi7+Ejor6rE/0yeN+zjG6QXfAJTS9phX8he+eF4cr+JUtHLoR6XaRAAa5i
	118lhgyW31URWp3GO5/x5W+P4iIBmbc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-548-5HzE9HeKO6yi7gZfoXToLQ-1; Thu,
 31 Oct 2024 04:51:05 -0400
X-MC-Unique: 5HzE9HeKO6yi7gZfoXToLQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F13F21955BC1;
	Thu, 31 Oct 2024 08:51:04 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.59])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B73B1956086;
	Thu, 31 Oct 2024 08:51:03 +0000 (UTC)
Date: Thu, 31 Oct 2024 09:51:00 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] hardlink: add --list-duplicates and --zero
Message-ID: <poldiwddvocjfuycz4itjwpv37ujpbnsei5xdsq75tczrofkbw@n2deqipztqae>
References: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
 <b22071e3546940d6d0fa6e1d9d03f292e18229e2.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b22071e3546940d6d0fa6e1d9d03f292e18229e2.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Oct 28, 2024 at 07:19:30PM GMT, наб wrote:
> --list-duplicates codifies what everyone keeps re-implementing with
> find -exec b2sum or src:perforate's finddup or whatever.
> 
> hardlink already knows this, so make the data available thusly,
> in a format well-suited for pipeline processing
> (fixed-width key for uniq/cut/&c.,
>  tab delimiter for cut &a.,
>  -z for correct filename handling).
> ---
>  misc-utils/hardlink.1.adoc |  6 ++++++
>  misc-utils/hardlink.c      | 21 ++++++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)

The new option should also be added to the "bash-completion/hardlink"
file. However, I can fix this after merging locally.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

