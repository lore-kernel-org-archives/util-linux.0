Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ABF1FBC92
	for <util-linux@vger.kernel.org>; Mon,  5 May 2025 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746438629; cv=none; b=jLfDA79MJxdLnQz4h4OvHse2Bbfp4eo+ym50ZiDtjIfobWp723HZNq8RoDLHvT6c4PUJ5FJ6iNNOV7iJzXlh7ffC8Gp7wxB6/Vi1JVIDFyZhEqbOXeh8wA4gnEQkj9BIQo/b6TLPSPn/SGVyRztsuhWePStGcEdyKybdRBbf5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746438629; c=relaxed/simple;
	bh=n5BIgeXIQ69Et6gUi0sFrYivWTW2s7B3y3hA63mApKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8BMFqNcKg2AgDAmSfSqVDTHqOwZh1FLGKWFeMWkA4ptYE6oQRhIT0852vutIrvZQjdsA0fYZIcxqwBgZhFq6BIVm9oJoPRNr1S9tI9OV6teFSk3sJzU4zRN8Tr7iIVS8I47KLxj7uDKknMU1XyC1LBprXtHUX8SHRA48A2JSLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCo5rFgn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCo5rFgn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746438626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KjDhMGgIeYeybmB9solXk27GilA5Cymsc0Qfk6r1arA=;
	b=YCo5rFgnGrwyIFt6ff0O2iZmmoNUtCqDR+ONxn8ZRetkzRYnHDLeoFBhlrGalnihULKRC3
	kyNhnRJKqkVkcIkbps1DifWB7aUtEs4ymc5Er4dueXIhhk9jtroOfAGpsSAJo57B8kz5wh
	o2UP5kkqcJEua7yP9AWk2MH2tbzavb4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-426-lVxODl1hN6CrgbXQtE2U2A-1; Mon,
 05 May 2025 05:50:24 -0400
X-MC-Unique: lVxODl1hN6CrgbXQtE2U2A-1
X-Mimecast-MFC-AGG-ID: lVxODl1hN6CrgbXQtE2U2A_1746438623
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C67061800360;
	Mon,  5 May 2025 09:50:23 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C99B01956096;
	Mon,  5 May 2025 09:50:22 +0000 (UTC)
Date: Mon, 5 May 2025 11:50:19 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux-2.41 breaks static build of btrfs-progs
Message-ID: <hjy6pccal442gk26tgjkol43aoicvkak4p2wy64ouk2ksfdhjb@7a2yap2jorf4>
References: <ddfd6167-e88f-4505-8768-a9d8e1d5cc92@suse.cz>
 <vy5gwsr6al5wl7nlksaq6orzkhhp4tog7gxtsjchl76ess5rtc@tmkazaywmvgv>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vy5gwsr6al5wl7nlksaq6orzkhhp4tog7gxtsjchl76ess5rtc@tmkazaywmvgv>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, May 05, 2025 at 11:34:11AM +0200, Karel Zak wrote:
> On Sun, Apr 20, 2025 at 09:24:43PM +0200, Stanislav Brabec wrote:
> > Static build of btrfs-progs fails with util-linux-2.41 with a simple
> > problem:
> > Symbol parse_range becomes visible in libblkid.a, breaking parse-utils.c in
> > btrfs-progs, using the same symbol.
> > 
> > The question is:
> > Should be this fixed by util-linux by prefixing of ul_ to all symbols that
> > are not declared as static?
> 
> I think the ul_ prefix should be used for all generic names like
> parse_range(). I'm not sure if I want to use it strictly for all
> functions, as the set of functions is large and such conflicts are
> very rare.
> 
> ChatGPT has an interesting suggestion: add the prefix to the .a
> library using "objcopy --redefine-syms" for all non-API and non-static
> functions.
> 
>         #!/bin/bash
>         PREFIX=foo_
> 
>         # Extract all global (non-static) function symbols from the .a file
>         nm -g --defined-only libmylib.a | awk '{print $3}' | grep -v "^$PREFIX" | sort -u > tmp.syms

Note that the list of symbols should also be filtered according to
libblkid.sym to keep the API functions unmodified.

>         # Generate rename list: <old> <new>
>         awk -v pfx="$PREFIX" '{print $1 " " pfx $1}' tmp.syms > rename.syms
> 
>         # Apply symbol renaming
>         objcopy --redefine-syms=rename.syms libmylib.a libmylib_prefixed.a


Updated, not tested version:

#!/bin/bash

set -e

LIB=libfoo.a
VERSION_SCRIPT=libfoo.sym
PREFIX=foo_
TMPDIR=$(mktemp -d)
RENAME_SYMS="$TMPDIR/rename.syms"

# 1. Get all defined global symbols in the .a (non-static functions/vars)
nm -g --defined-only "$LIB" | awk '{print $3}' | sort -u > "$TMPDIR/all_syms.txt"

# 2. Extract exported (API) symbols from the version script
awk '/global:/{flag=1; next} /local:/{flag=0} flag' "$VERSION_SCRIPT" | \
    tr -d '; \t' | grep -v '^$' | sort -u > "$TMPDIR/exported_syms.txt"

# 3. Compute symbols to rename (non-exported global ones)
comm -23 "$TMPDIR/all_syms.txt" "$TMPDIR/exported_syms.txt" | \
    awk -v pfx="$PREFIX" '{print $1 " " pfx $1}' > "$RENAME_SYMS"

# 4. Apply renaming to the archive
cp "$LIB" "${LIB%.a}_prefixed.a"
objcopy --redefine-syms="$RENAME_SYMS" "${LIB%.a}_prefixed.a"

echo "Renamed library created: ${LIB%.a}_prefixed.a"
echo "Renamed symbols:"
cat "$RENAME_SYMS"

# 5. Optional cleanup
# rm -r "$TMPDIR"



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

