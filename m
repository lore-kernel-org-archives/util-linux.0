Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A1D1DA4C
	for <util-linux@vger.kernel.org>; Tue, 10 Sep 2024 10:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965142; cv=none; b=GmqwYFGueeXsxPvVmHuwz5VToLeoG0h9smG1+MqGCBWhZA/AVehzv2e8jbBxja/WvR68h7xKM8WR3F8tO2q/MDnBB+tnG65K/S8Lt9SjTyhzklOOfm8+p59iR9KeVLrH/ia4TvVS2cqYmNFSiWb02sulD7bJjmbw3/Kyl8jnj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965142; c=relaxed/simple;
	bh=txabAs53lw+/+fOWmTF1th/voXP+j2OD14dSt3UzU9k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkfHhlxzCK+k7FdlcMV4DLUOkjxBSpR+JEUVQHxrwLkXiM/PONfTfqr3Va0Rn7KaFkKsJ9xFqkCMEYew3/1hFYrwKbgtwA6EMVLHbxK5SZee0khfBByriDPSrasumTbTD9KwrTlXfEnkFTjtcCuC5AMBEZV8ugzUoyMVXt4z3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GD7QcH1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GD7QcH1a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725965139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xrd6Xca0fCoGtbeec0bXoHKgl0bwHdz86vASaITOBYk=;
	b=GD7QcH1a4Nt1PNanHBcaSbBqIPOJCiO+QwIqDHS/ypKpI3uZoqa64XIj6UNsAgAn8ogU66
	GpjYBPrcD2JxHUbeVWjMiK0W+IWDmV9lwpKIG/+Mgl+Y8gfVNrPDFzzd6AQEhNHOEfmpUB
	dSuH4S99Cf1FxeD3X6PPYpfp7KUi8fY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-ZNOUJ1ooMHKKapE_lRQnYg-1; Tue,
 10 Sep 2024 06:45:36 -0400
X-MC-Unique: ZNOUJ1ooMHKKapE_lRQnYg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C1851955D42;
	Tue, 10 Sep 2024 10:45:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDFC819560AB;
	Tue, 10 Sep 2024 10:45:33 +0000 (UTC)
Date: Tue, 10 Sep 2024 12:45:30 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org, ptxdist@pengutronix.de
Subject: Re: util-linux build error with meson and older glibc
Message-ID: <llzewq5lplvpsvbu3pg57papu2sa7ojrd6cp62vgq6hkdvrukx@wp6bt6csap5c>
References: <13593969.uLZWGnKmhe@ada-pc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13593969.uLZWGnKmhe@ada-pc>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Sep 10, 2024 at 09:07:01AM GMT, Alexander Dahl wrote:
> building util-linux with ptxdist [1] here.  After switching to meson
> build [2], compiling util-linux fails with OSELAS.Toolchain-2020.08.0
> which contains gcc-10.2.1 and glibc-2.32.  Building for architecture
> arm-v5te-linux-gnueabi here, console output below.

Which version of util-linux are you currently using? Is it the current
git tree?

> From looking at the linker options I suspect -lutil missing?

It seems so.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

