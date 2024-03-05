Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C344855C2E
	for <util-linux@vger.kernel.org>; Tue,  5 Mar 2024 09:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630142; cv=none; b=jmej1xa3TlkVaS4JARMnqB71AJu8i5eZYTvq8hbjcLXLnGItu7zdW4XVWKIGIh6e0Whhk163mBQUg7dl41xMDis3izEQJl+Z+5iNAxbTmyI/uHGewXd0nUhCnIaKwbX2rPZSmqxLTKglq6rcua4WajjgWRlBiOJInr1L8ALKl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630142; c=relaxed/simple;
	bh=fna56MCogaMbJk5yBv/pZhLZzsaCtZAX/+Tx2iFxSLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvaA9dcDpF1qWB3KDWmVxvuQ4SFIEby4EVdL3ZEDwX1CUdErlcsOnoSsujT0yohbhqrdh942nZPF/ppvq+PN4e2RqP/J9SkQdWGzuJ8obPGCixVkWjqCly+F76h4/Xap4cO6UQZNwj9PzcKgzAggAGwrQafPg9BiAhBGaQa8VyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDRZhGBd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDRZhGBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709630139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aoKjCxofnGk2howb2IFNmi8XVnmqot2Tiladhp+XsYk=;
	b=DDRZhGBdfFr56Xb8JNuLXZg19dtW19oLxLiA+n3c39OXXbt7bSPb0TAQ6p12b0rumHnrFu
	EPJshwb11H2cuqKFOJH6sGu9r0SHkzWPa9tw0yYifUmLRFp15b5RLW7MtyNl24N9aQR98q
	yks1VP/uLhOWjwKLriioNo836BK3vEQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-pKJ7fPOWNeCYTCV42dVVBQ-1; Tue,
 05 Mar 2024 04:15:36 -0500
X-MC-Unique: pKJ7fPOWNeCYTCV42dVVBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3F673C0EAA7;
	Tue,  5 Mar 2024 09:15:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 716104038E81;
	Tue,  5 Mar 2024 09:15:35 +0000 (UTC)
Date: Tue, 5 Mar 2024 10:15:33 +0100
From: Karel Zak <kzak@redhat.com>
To: Tanish Yadav <devtany@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] su: fix use after free in run_shell
Message-ID: <20240305091533.vckd6b2sxlkpbbcb@ws.net.home>
References: <479fd0b8-bf67-4370-8250-bfd136a08195@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <479fd0b8-bf67-4370-8250-bfd136a08195@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Tue, Mar 05, 2024 at 12:51:41AM +0530, Tanish Yadav wrote:
>  login-utils/su-common.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

