Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EF623C50A
	for <util-linux@vger.kernel.org>; Tue, 24 Jun 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750756880; cv=none; b=jltQxxBXPclZDCdtdWhfV5qq4e4M4F6uVT+84jNmvyh5OycHjt7t/EShFQMoL4KTcHgD0PDnRJbeN5cHBLWc66F8QHLhuXad9QOI/VlgXEAEmNvgTHQBKJTb4fVXvM6E7uxPvA+JU1zCRgdZULNlpmIOh/yjOLPy9zoSD7PvroU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750756880; c=relaxed/simple;
	bh=07YR4Q6RNKEgyi2kR/dNO6koj8hg4Y9iCeEI5Saq+mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7sPJz3AYXld0spFWx6k4Qih0cl9IVlvN4EZfbd9tyTvnu79R9MIWk/KV5FSvWypkBi8ZzqoD72YQixtUwHd9Aseevxr+ajcDyu1pbHL9w3YzPwjFRvM/0VM5TXZTObQ/cZQLG00Yh634Ag5wSOr7dUZYhEik5AaWmMpwa0MHlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJDdLXpo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJDdLXpo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750756878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9wuKwptviZV+rgAV7+YDM/S/cfW5uLIgnBpkAGYGwU=;
	b=hJDdLXpoHM1udx+IWqYhMq+6BlJj2gkKG/u9mMO8I4SiKN06Vhrtrac3QgoiCAGUqFkXMv
	FUOyIO9vpruiPmJGu0O6Vg7n75WBp1Qdl8y9fERu+I98awuvdFSZlEwttyVeYxvpXKppPC
	OI/ufKnhVYqY0/G5BEoYeN0VyeMtdLc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-cDd__92WM-u5UotVu7AnzQ-1; Tue,
 24 Jun 2025 05:21:12 -0400
X-MC-Unique: cDd__92WM-u5UotVu7AnzQ-1
X-Mimecast-MFC-AGG-ID: cDd__92WM-u5UotVu7AnzQ_1750756871
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7136B19560A3;
	Tue, 24 Jun 2025 09:21:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E34C1180045B;
	Tue, 24 Jun 2025 09:21:09 +0000 (UTC)
Date: Tue, 24 Jun 2025 11:21:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: util-linux@vger.kernel.org, Benno Schulenberg <bensberg@telfort.nl>
Subject: Re: [PATCH v4 0/3] chrt: Improve argument handling and allow
 optional priority
Message-ID: <m7sa75ylq3yepezu5vz3f2bupxuked2jeg3rpeb4ufde3d7ja2@u2hdknnv32ed>
References: <20250621195048.24900-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621195048.24900-1-vineethr@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sun, Jun 22, 2025 at 01:20:45AM +0530, Madadi Vineeth Reddy wrote:
> Changes in v4:
> - Rectified my mistake of not giving proper space in a comment in v3
> 
> Changes in v3: 
> - Made --pid consistent throughout (Karel Zak)
> - Change get policy to not have policy options (Karel Zak and Benno Schulenberg)
> 
> Changes in v2:
> - Updated the man page to reflect the optional priority behavior (Karel Zak)
> - Renamed variable to 'need_prio' (Karel Zak)
> 
> Madadi Vineeth Reddy (3):
>   chrt: Make minor cleanups in chrt
>   chrt: Only display current settings when no policy is specified
>   chrt: Make priority optional for policies that don't use it
> 
>  schedutils/chrt.1.adoc | 24 +++++++++++++----------
>  schedutils/chrt.c      | 43 +++++++++++++++++++++++++++++++++---------
>  2 files changed, 48 insertions(+), 19 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

