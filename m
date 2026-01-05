Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465833D6C0
	for <util-linux@vger.kernel.org>; Mon,  5 Jan 2026 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620117; cv=none; b=TsMpI4LnB7XvZF4rAUfNwwNGF1/7Yh3wjBObvxUjB4W3ZgeJ6J/to6C8W6A9Utwdg0Ua5eDDGVPVjsnqSwablgZSmlhChT0UY8e6IhVx2k1jqDbIA5OI0wKp6msMZx+Bs11DLnIxOClOjR8k+JARGk9IkRTPNrUKcd87F31byOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620117; c=relaxed/simple;
	bh=nWnOJhxIoxNbrkzB6CEPWoH+6lEBiHCi9hsgg8wHCCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp4UJ9Uuz5ZQJan+dqxdESTeZQg2iv9b/NMx5uWhy2ZKMmzAON/edNjZrf4FUQk806qpVPzD4ymG6DofrUrFWz5nbKUoNn8TQgUKkl0suYFOoK6QROzVneJxcZ+0/Uf2X2ir1dPT6L6U1GcuGEJn4OfvPvyQlyUBVpqlMkeKig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KVXWZ2hw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVXWZ2hw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767620112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mqBBcwXSgiXRWtlK6iS0F0CvrJ9z+wv9c/psCdLJ0Fs=;
	b=KVXWZ2hwvmM7UeocNmn1Lklih86Oif7FC1mmJ6XOHg+NKvZkzhAH0c/DVd7XucHX7xnLJs
	mgnZUn1el+40HW0FBHd7uSzXeqv63FSwrudgGlgFc/wpgILhrtALWdAYgECThhawqjZRPA
	R6e+bMsj4DrzeTSLTHshscXSzqdHWYg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-UzzMh2pSMHeo4E1U9L6knw-1; Mon,
 05 Jan 2026 08:35:10 -0500
X-MC-Unique: UzzMh2pSMHeo4E1U9L6knw-1
X-Mimecast-MFC-AGG-ID: UzzMh2pSMHeo4E1U9L6knw_1767620109
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB2C5180062F;
	Mon,  5 Jan 2026 13:35:09 +0000 (UTC)
Received: from ws (unknown [10.44.22.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 845EE30001A7;
	Mon,  5 Jan 2026 13:35:08 +0000 (UTC)
Date: Mon, 5 Jan 2026 14:35:05 +0100
From: Karel Zak <kzak@redhat.com>
To: Kiran Rangoon <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org, thomas@t-8ch.de
Subject: Re: [PATCH v5 0/4] libuuid: Fix pre-1970 UUID timestamp overflow
Message-ID: <t3atqsumbwyl4rinn6apd2ywiy5vqk4fsjc3ztct2z7zs546jq@haxwj4uxpxlk>
References: <20251229035100.5778-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229035100.5778-1-kiranrangoon0@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Dec 28, 2025 at 10:50:56PM -0500, Kiran Rangoon wrote:
> Kiran Rangoon (4):
>   libuuid: simplify gregorian-to-unix offset calculation
>   libuuid: refactor gregorian_to_unix to populate timeval directly
>   libuuid: fix timestamp overflow for pre-1970 dates
>   tests: correct UUID timestamp test expectations

Applied (from PR created by Thomas). Thanks to both for all the work!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

