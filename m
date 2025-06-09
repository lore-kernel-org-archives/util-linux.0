Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7B1F7904
	for <util-linux@vger.kernel.org>; Mon,  9 Jun 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749473109; cv=none; b=T7nTgma3UehkMgPT0tAqFS4ZfxTuSIZW5O+v58MWzonbqmccJvJTjT7lWdU4eFtA7dTfjgUWXOstanBWPi2Gn2FHQUMiDbNed8VTgxYMavxugIQCHqMYfGgfWutiIrfmkccu927hS3T/rAshttS0TJEFZ3/p4pS90AlMb4iKfC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749473109; c=relaxed/simple;
	bh=hfeI4joQZ67lwr0rYvZIXw/yoJ81tv+oIcCTIXmWNg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9iYREQLHLs6esDN8ZPYQ5teDZgeGOdaW7jpvtb6o5K3O11HkQpFq7BT/IaGFqm4G4EjO6QW0EEkPJhaBuSzbaO+7UJ7igBnwQxGqNmfhmzXpO6/kCBpwNIk/lHkjofAI4mylWjHyuEm0YeeORt0EUcxFiDU7GiYpe9ZkZpqA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOfr9kF5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOfr9kF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749473104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i30FyL4iKrGbotUTutUUkMD5lg6M1f82qgW008qczEQ=;
	b=FOfr9kF5tfkhQha3hHAJfj/bZ7lhLBlDoHSMxaQdINxH3H6uuz+Bm/irgA7cGQDUvmi+7Z
	RpHbC7cqz0cVVU3p0qKZudI1HPfasplndaNaUx1vDG0oW8FeJqSlOMpqcIIVpZDvmVyDaJ
	z2PAqEfux5AmiOAbCEO20i518wLJ4DM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-U6OVGhVSPRuObKN8z68C8w-1; Mon,
 09 Jun 2025 08:45:00 -0400
X-MC-Unique: U6OVGhVSPRuObKN8z68C8w-1
X-Mimecast-MFC-AGG-ID: U6OVGhVSPRuObKN8z68C8w_1749473100
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91C4218002A1;
	Mon,  9 Jun 2025 12:44:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CBDC30001B1;
	Mon,  9 Jun 2025 12:44:57 +0000 (UTC)
Date: Mon, 9 Jun 2025 14:44:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] remove two leftover license lines from colors.{c,h}
Message-ID: <jxbrf6o4r5y6d7gwyciql2ichmazhtwvg3sauqqz5lkkkpwcda@q6zexad6bcev>
References: <20250602141436.11156-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602141436.11156-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jun 02, 2025 at 04:14:31PM +0200, Benno Schulenberg wrote:
>  include/colors.h | 3 ---
>  lib/colors.c     | 3 ---
>  2 files changed, 6 deletions(-)

Applied (all patches in the set), thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

