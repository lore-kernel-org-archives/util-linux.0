Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E526C3B0
	for <util-linux@vger.kernel.org>; Tue, 16 Jun 2026 12:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613275; cv=none; b=H7SteeC3kwdvmPIJuWTuC/XZ8ZYjFcK8rnNlX8taVHZDEWO1pUTFkfmUlbnN1bZg8Ggt3ZaL0lN/jUYpOd5oQRJuBGICZ7XtoMB8TCRl0UcrKhZzLkzhnlxZBtHzXRdCOZ+gGSQR//Tw5T3D+fOnvUUS6wXUB4/faDairzoWgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613275; c=relaxed/simple;
	bh=dHYXSuMIuncDCQHUa2kWZmPKgrl3nU1x2uQFJeuEmQU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I8Z+iymk5bWji9oNVqeeseO2zrchi0IjkLsS8CslByiIt7ej56megAABJ/jA0n3vtmOuPmQEbUXGDZE6FsYlZUtflWEwXnFmIlPfd9freUDtRttSrXfhSs3EpH9/1V+yRD3HHLrwheayV1H14YNcWxC7F3us6x8x0fUJI7W6LRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zm0DgN4T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zm0DgN4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781613273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=l7dJghem+f0E2akGXB5TbSpsh9R99AMpixwdVcMXjus=;
	b=Zm0DgN4TCxkuF6WgKZh8Bh7SYQ1Ef13KpONKISZdSbFGY7eeRPT513FUmVx8/np1ZfPNU/
	2XgYOERSAj+sCWDh4Kqp3T1k8D9B+IPjBGrg6giyK05smqcBgqcenz2JsH/ZJZO8O6eb8k
	WYZpLQmpAczWTL3C3lYuuvhdfBCYu9Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-xPlpVIcHPxelqkxmk4Yq9w-1; Tue,
 16 Jun 2026 08:34:30 -0400
X-MC-Unique: xPlpVIcHPxelqkxmk4Yq9w-1
X-Mimecast-MFC-AGG-ID: xPlpVIcHPxelqkxmk4Yq9w_1781613269
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C3FC18004A9;
	Tue, 16 Jun 2026 12:34:29 +0000 (UTC)
Received: from ws (unknown [10.44.50.174])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E007C1800594;
	Tue, 16 Jun 2026 12:34:26 +0000 (UTC)
Date: Tue, 16 Jun 2026 14:34:23 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.42.2 and v2.41.5
Message-ID: <c2fo4x3lcppsj77k564i4qodmon3wagx47qf4mqwjwdtiplupg@jmaqrlzp273h>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

  The util-linux releases v2.42.2 and v2.41.5 are now available at

    https://www.kernel.org/pub/linux/utils/util-linux/v2.42/
    https://www.kernel.org/pub/linux/utils/util-linux/v2.41/

  Both releases contain security fixes for libmount and libblkid:

   CVE-2026-53613 - mount(8) TOCTOU race on target path
   CVE-2026-53612 - mount(8) TOCTOU race on post-mount owner/mode change
   CVE-2026-53614 - mount(8) SUID bypass via LIBMOUNT_FORCE_MOUNT2
   libblkid use-after-free in nested partition probing

  v2.42.2 additionally includes a follow-up fix for CVE-2026-27456
  (loop device symlink attack) -- the v2.42.1 fix used O_NOFOLLOW
  which only rejects symlinks at the last path component; this update
  uses openat2(RESOLVE_NO_SYMLINKS) to reject symlinks at any component.

  Note for v2.41 downstream maintainers: the same loopdev follow-up
  fix for CVE-2026-27456 is available on the stable/v2.41 branch
  (commit 2dacaf3ee) but did not make it into the v2.41.5 tarball.
  Please cherry-pick it into your builds.

  Release notes:
    https://www.kernel.org/pub/linux/utils/util-linux/v2.42/v2.42.2-ReleaseNotes
    https://www.kernel.org/pub/linux/utils/util-linux/v2.41/v2.41.5-ReleaseNotes

  Feedback and bug reports, as always, are welcomed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

