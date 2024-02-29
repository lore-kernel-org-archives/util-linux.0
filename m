Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DDC7828A
	for <util-linux@vger.kernel.org>; Thu, 29 Feb 2024 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233026; cv=none; b=fEeW7NZeoMGHFcXhmVzD67rX/CSys33McOaJhpVaBjgYnHEuIyV5+Y+w34Fuq/+YLvqRIlT4Ndl9bNQ92gN13qXCu1upHe+vpvn5FN9faugbWPO+ls8C468s9jsOHLTfMKaQqAy3zNXPxnlVLjbS7YrFFR2kAnloQYZMdtb0L0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233026; c=relaxed/simple;
	bh=WpOcRppP6AZpU1Rm/59qLmcVUuSuiLxQ16TZrcuniIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGASncnN8HF4gSLPn1S8TlRa3A+L5jJL9fjv6/wnwUVw9TwdkvLSLt2yZoczQYO8/U7sk65sbapWct+30ejgDgydTFGubJdoJ9xSI6eMK5nfaeSKarxqq3jWXFMkcXieW5Q79Z28txOWOC2Q8GwlV3EpTd93agRhsTsXSvGnbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAK7K8e/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAK7K8e/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709233023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lpc3vWy6L9wByGZtn5XHnDDbC/daAMM6UVVwUbxBpWs=;
	b=jAK7K8e/COK7JBluf22F0S4LRcSxuk4ZNw69DjehiXcane4aarDfb1dQDFur7ij4QGskj2
	x7Q06FfHlQitzJ6rROOzsIq/gtwjK3UGvqBiwrQNgQPRpIW6auE5MgyRGThXm+zXgsSO/s
	gw5w1B8UlkfPDW8kqkK8D2zWAsnRTN4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-SJ4KGM2VN8--8R7GIE_lsQ-1; Thu, 29 Feb 2024 13:57:00 -0500
X-MC-Unique: SJ4KGM2VN8--8R7GIE_lsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 032FE10AF918;
	Thu, 29 Feb 2024 18:57:00 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 846241121312;
	Thu, 29 Feb 2024 18:56:59 +0000 (UTC)
Date: Thu, 29 Feb 2024 19:56:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] setterm: Document behavior of redirection
Message-ID: <20240229185656.l4cv5ptko74yydnz@ws.net.home>
References: <2b12341f-5935-463c-8301-a4a4f139541c@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b12341f-5935-463c-8301-a4a4f139541c@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, Feb 28, 2024 at 03:06:14PM +0100, Stanislav Brabec wrote:
>  term-utils/setterm.1.adoc | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

