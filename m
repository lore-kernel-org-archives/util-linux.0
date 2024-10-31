Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F0161310
	for <util-linux@vger.kernel.org>; Thu, 31 Oct 2024 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364523; cv=none; b=Si7ag3tJlMCAxFINLpj8u6EIVsw0LKgxmBOPKDlfTCR1l79py6lWUoilZgBEhvXNnTJgKEG3y/91PFEGchgBZmfrD4sY5LAv0NnrZh2niJC3Qj1Oxid0tbv7lN4QkbHsnYVYOhhwLUE6CsyZddDLlsVJj9WjhCLrJMhOk3VxeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364523; c=relaxed/simple;
	bh=DNQrowQh6In0Fu+h/U+cboyLquxP00ZkoC8O2OieWZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6dSjMS33EQ+SwPlNTSzLo1bT2vHoK4jgzefXBIvPIMp8a9KXOGLuozdJgCUXbQw52s+OOlgLUcs9NtqUsXSmYzv7SkknVwuIZl1XjprY3FFx+8ttUOS69GcNrXk+E8apGm85bG0G9ZBvSF6sCRxcOXJpq+wMhPWcgX+1Jat4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShWvzmvl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShWvzmvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730364520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KEa04HqcDKSfTYuKtnlRI77V8n/ltZxgyKmiH+cCB0=;
	b=ShWvzmvlu60/K6hu0RR9r6rYHCgHFps6AehzEWKTwFPJx8UoxNlUMCxR1hCQfw4lv7/72V
	Kgo/qgV2tbOTsSrNme0VkufMK8woBm2+51mLsYZP0pEdw7Q621VZKnY/6OuXBDfc8aOVub
	vhrrcMo1LI1Z61Uqk415UR61rzbo+9M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-sgu7NJVbMPWxKYnlV_kXng-1; Thu,
 31 Oct 2024 04:48:36 -0400
X-MC-Unique: sgu7NJVbMPWxKYnlV_kXng-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38193195608F;
	Thu, 31 Oct 2024 08:48:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53ED919560A2;
	Thu, 31 Oct 2024 08:48:32 +0000 (UTC)
Date: Thu, 31 Oct 2024 09:48:29 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] hardlink.1: directory|file is mandatory
Message-ID: <jom5nfuzdf3z5ihcosusxbmi2xqe2ebwjdnw34rdvopyx5e3zs@pq3j2vkpib7y>
References: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5acde6a911f086ab8d2314c5b76eb76075140941.1730139540.git.nabijaczleweli@nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


 Hi,

I have created a pull request to test the patches on our CI.
https://github.com/util-linux/util-linux/pull/3260https://github.com/util-linux/util-linux/pull/3260

 Thanks,
   Karel

On Mon, Oct 28, 2024 at 07:19:14PM GMT, наб wrote:
> ---
>  misc-utils/hardlink.1.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
> index d11045941..b6f07ba70 100644
> --- a/misc-utils/hardlink.1.adoc
> +++ b/misc-utils/hardlink.1.adoc
> @@ -18,7 +18,7 @@
>  
>  == SYNOPSIS
>  
> -*hardlink* [options] [_directory_|_file_]...
> +*hardlink* [options] _directory_|_file_...
>  
>  == DESCRIPTION
>  
> -- 
> 2.39.2
> 



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

