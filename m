Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE3189F56
	for <util-linux@vger.kernel.org>; Mon, 26 May 2025 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279309; cv=none; b=M8oDnwcHIaoIinkeYyRQlHWrPcWYxP57aD8evQvltDXUnvZ8v/SFyu12WEJMTccwsqwk1JdiyjrzMe6ARsVWsRUuKpi28Fnmu/9I5TbYWmjmQJHVNkWGKEASRBt5c5I1vSZLTe3ZFocXYmN+bOxpRT4FOQ2N/lMlddbajc7Xe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279309; c=relaxed/simple;
	bh=Vo9fivLs1LSaI+Fx9oJByeVNlG8VXKcpPHnJzhrNPcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTopb8z7F6J5w2V4PPnJd/qUsfTM12gn/46+JjUhLfgsNgAtcICw83BViemCz0er3GypPhS1i6VUj92dA2+e48jHgbH+uQ2Mk1GOvATx9nRQF4Ufc90DCVdfnVYYP0yP0JFNgOeO7/z7VzFAzh9gyt0sZSq2HO4F+BFoCLAgQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JdcdsXrO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdcdsXrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748279307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0nZucPQRdy73fsgwZZEeK964fRIHACqaU1G+CvgVEhA=;
	b=JdcdsXrO5wYpCP5q5J95qQvvnFFgU3I5Sc9bLsqRqnk+VVSEIrNG5EimK4RSvm8i67NIJO
	Mxqu8BB4EfFKgbpNH29oVYvNGi1QOSrC3zBO/BrHEuLblA9SiKHmtzZgyQlzF15vhWDbiS
	QFJ1I3BcfyJ1CsSrVi+lDgKqIzCIzvo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-Dc7xXHgOP9SNBhSlQ2z3uw-1; Mon,
 26 May 2025 13:08:24 -0400
X-MC-Unique: Dc7xXHgOP9SNBhSlQ2z3uw-1
X-Mimecast-MFC-AGG-ID: Dc7xXHgOP9SNBhSlQ2z3uw_1748279303
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D21D1955DAD;
	Mon, 26 May 2025 17:08:23 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6385E195608F;
	Mon, 26 May 2025 17:08:21 +0000 (UTC)
Date: Mon, 26 May 2025 19:08:18 +0200
From: Karel Zak <kzak@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] AUTHORS: update Zhenwei Pi email
Message-ID: <aneasa5r4rbhahmvui5iw4njivy5ilkl6mayqc7lblpvysgyxz@htfqpyxrpb7e>
References: <20250526093817.951024-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526093817.951024-1-pizhenwei@bytedance.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, May 26, 2025 at 05:37:57PM +0800, zhenwei pi wrote:
> I will be leaving ByteDance so updating my email in AUTHORS to my
> personal email.

Applied!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

