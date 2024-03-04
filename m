Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC2B27702
	for <util-linux@vger.kernel.org>; Mon,  4 Mar 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709555649; cv=none; b=eyjrTQFzhbUmgzEqD7GCBzYjUFofnynEeBlPw2PqEfjw7L9HwLoVWDOOyZxIwfWdaLBvwrpPl95ucslVpy28v5eR6x5cOzmQlK0EzY0Ykt52dbmHNsOy6BqvykNC3oWTveOYw6xboH12Aom6K0NC+NbRklzYR7aEviOM4OE7V4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709555649; c=relaxed/simple;
	bh=BlCPsgkg47EqLNmO3m1JsFSABMKmISVifZjogXqjvOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nu5FwsHMltf4MHgqlF5KmfKtkXnBbOVYgNcRFbAR5eyZrGe+XI+/1dazjgUKfKd+k4QGM/uXHkDqGBx5OH+95BcYPNhuWAQsKga23HawiycOzl8V8cMkWWnlLEA120irglFjbogha0ud9rNfnY+Hl2SUZG1pO4V/Akx3GhB5EKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfLXv5U9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfLXv5U9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709555646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KCw95pKZtHf/HSKAre2hpw3GKavMo53GHRN0Rzk5bGo=;
	b=GfLXv5U9Odmv1SeaE7xDpiEjVKO9P+tAEogSuxZk7essc4rjebVtSreeFMlsMVzrjsb18J
	W91VlZTHzi3KMzbdni+Fz3x1WqKCrRjqhAuEPIJy1W9RyqzlWYDvpB0KRkYA0zSUcbyheS
	kCO3O2DiCd/xWKoxsaCDaC++q4RRwWU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-BXmly9fNOPONEQt6UWWLSQ-1; Mon, 04 Mar 2024 07:34:03 -0500
X-MC-Unique: BXmly9fNOPONEQt6UWWLSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB6561066689;
	Mon,  4 Mar 2024 12:34:02 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D32E11C060B1;
	Mon,  4 Mar 2024 12:34:01 +0000 (UTC)
Date: Mon, 4 Mar 2024 13:33:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, util-linux@vger.kernel.org
Subject: Re: Escape sequences in /var/log/auth.log
Message-ID: <20240304123359.ruh64pobvg53r7f7@ws.net.home>
References: <CAEOG19pNSdEMjyoo_=s8-WqVs+jrmaaU=CjRb0oxKw1FG00xSA@mail.gmail.com>
 <20240302173316.GA1508977@mail.hallyn.com>
 <ZeRYJ6HD77humJzg@debian>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeRYJ6HD77humJzg@debian>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Sun, Mar 03, 2024 at 11:59:51AM +0100, Alejandro Colomar wrote:
> This seems to be a bug in util-linux, not shadow, so I've added
> util-linux@ to the thread.

Fixed. Thanks for your report.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

