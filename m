Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47B762FF
	for <util-linux@vger.kernel.org>; Fri, 26 Apr 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118405; cv=none; b=BAgLwMET2/i3Zo1aY3rIBIdBcJIEOMBxXNZ7EPuVFIMRqlXqRbW8iKc6UO8xHps8BHwecYMBGbkwN9NV1ISjEGAP/2VZlnumLrfCmZdqPTano1X2COCgzjEngcTaI7Q9aOes846XDcbImv9QKDy7PwBLb47ZIrwbAukh7ALUT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118405; c=relaxed/simple;
	bh=/u89fCbNWKl0AIA5hJCFToPHxnzk5FSAwOYUvlQRMz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anVA6Zb7C2R+ZVt35XabwdQUqToM8OzGg3+DoPoV7tJmmCnsdsO8pXwElZaD8feDe0T3oLEacSx+xh/xpDkO1LgxwJ9Nr/zSYgffz8AdTz1hm5RUEPjXClHsNL0wCREytMTq9JZvNQPDc37+dFkiq78mg+Pvc4MM+8BcN8Y7RW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YlEBM1kb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YlEBM1kb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714118402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h8boJqGjuTDWBdvewRdvbGS5JeGTjbvSLfUNa0VaqOE=;
	b=YlEBM1kbhr4Whj6BtPFRCX0XNVaiLkWnY7CmfTNFHic0a56Pew3RVyXpnPb6i8J8dtjT3R
	Zitdpnr+AQvPAEitj5799T6NVrw4d7qQANJuTz7sq3cDnCNvAvG5W8BBI5RoMUR591hNVE
	hwasefiUk6AR6r7hHjY0CZ5IWqdZLmA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-WLuEUOD9MnCZBIoc8KhsRw-1; Fri, 26 Apr 2024 03:59:56 -0400
X-MC-Unique: WLuEUOD9MnCZBIoc8KhsRw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E5338001B2;
	Fri, 26 Apr 2024 07:59:56 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 95E1FEC684;
	Fri, 26 Apr 2024 07:59:55 +0000 (UTC)
Date: Fri, 26 Apr 2024 09:59:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Thijs Raymakers <thijs@raymakers.nl>
Cc: thomas@t-8ch.de, util-linux@vger.kernel.org,
	Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v12] coresched: Manage core scheduling cookies for tasks
Message-ID: <20240426075953.3zpdrcjgq76dfmz4@ws.net.home>
References: <295323c3-a43a-4f60-9c71-3b38a19b1d6f@t-8ch.de>
 <20240425162226.130639-1-thijs@raymakers.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425162226.130639-1-thijs@raymakers.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Thu, Apr 25, 2024 at 06:22:25PM +0200, Thijs Raymakers wrote:
> I agree, it would be better to handle it there. The error message "No
> device available" you would get otherwise is a bit cryptic so this
> is an improvement.
> 
> I've removed the ts_skip and added the case there.

PR updated https://github.com/util-linux/util-linux/pull/2990

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

