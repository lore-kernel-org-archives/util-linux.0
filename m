Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5603DBBF
	for <util-linux@vger.kernel.org>; Mon, 26 Feb 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937631; cv=none; b=Bl+lihaIk7203ix7/0r+prCPz9Jvx9wQYTWwuiX5FEZ+s7Fdo6RSCUuhyXAX7nv0k5rLfVmoRGVQ5GfKlJArI5GxlXPjXanbOxbJO4NDOs3ZVmDVyzXEpGt82dHJLVZNCft0g00yvifJNGYFpui3mNb317B7AuUFU/7FQa/SQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937631; c=relaxed/simple;
	bh=ks1TzqfLAAmQYflH39BufkRSgMYpNLRPJpj1swtNRIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0uZfb4wu1EvzrLqfI3e29y3KOQYX3CCTgoFTcUppN2YdSjf8kPaB28EM1FfrvlMJW6o+Dqcgzhr/ZQof8Kjo5xvCxEWih/PLdqnrptCCYYU+PtJ10UlwLCSd5i8fhI5EpfKOktfGCuBypE7tuPk/pXji44L7oqGZZ+Et0FI99M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAx5jKFr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAx5jKFr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708937628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eqftr/+UzQvGrmjy/hMToPBLMNjPBfYHTlOcGIF9eaI=;
	b=AAx5jKFrpgKjFiIr/gnXWij3s59EKtzuBxUxmizRCGcQtEu3sMEMGIWuL7qYgLGMVzFE9b
	zQ+Tp8yjvnelUQAIrP9eLY4Ub2HafZrlf0RsZLZFuCk6KX962fFwTqYzIfKucH45XwZxwx
	vWp/H45KTrkDegwTQEebaP95bCWKLP0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-jhyFpLOlNtOwh49q_jkhkA-1; Mon, 26 Feb 2024 03:53:44 -0500
X-MC-Unique: jhyFpLOlNtOwh49q_jkhkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 573CF85A58C;
	Mon, 26 Feb 2024 08:53:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 99B3E14F0;
	Mon, 26 Feb 2024 08:53:43 +0000 (UTC)
Date: Mon, 26 Feb 2024 09:53:09 +0100
From: Karel Zak <kzak@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: util-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	JunChao Sun <sunjunchao2870@gmail.com>
Subject: Re: [PATCH] libmount: don't hold write fd to mounted device
Message-ID: <20240226085309.zuz6ujeyto5kowip@ws.net.home>
References: <20240221173050.21970-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221173050.21970-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Wed, Feb 21, 2024 at 06:30:50PM +0100, Jan Kara wrote:
>  libmount/src/hook_loopdev.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

