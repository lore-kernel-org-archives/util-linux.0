Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735413D265
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484269; cv=none; b=BHcFT1HVDmTik6JxFFz3rYStuLnVq2dj5chertue9ErARskBNzloq2sxTP30o6c7I/grVmqDHVFqQGFYcgJ0Uc6rFRNDZ3eF2KMQn53cW9RdEgj9rTrrG531zWY/oSRKKmSM6RnPSYKIVBSzn0PBXEwfr7fgDpgrtMaf5wyEbp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484269; c=relaxed/simple;
	bh=8Dk5+WnwO1K6qsEmOBeF6B/UpVAu/qqTkmTVSkICcMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rsGma+B425ufZshoBgk3BnSJN8sj8Eg4AumT21e++Wik4lsBCKWJVr4V5NLDs4ukFPOdQk8Gd0JWDQKh5R/2SXAWSPxalCeS4iQD6W+LwNccwuDDGzxbCvskAWMYKnnrqWXdIzdJNXkMHfRWDDZCh8JtnA70thH5vTmjPMfpg3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTJ+aWqs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTJ+aWqs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711484266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oN3505lcOWtfHr+ljMF82R75jpSyodHXp8iyLKUgTLE=;
	b=aTJ+aWqsj66THorirX7de1Y3ujRy8o3Tea49CouEVBCUTfFJsE2gcMKhVjLiv6xw/OTP4d
	gC8nAJ1ndqBhLlCDZRUrflQGpjhZAyYNh2+k+9UdQTS0FVHD8ASc4GryAT+R/KhrC/vfli
	mUDqX/vOO1N7hpmq+6vJZide/j1y4vU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-JEjw6ms_PxKY0E4QMeWkVw-1; Tue,
 26 Mar 2024 16:17:42 -0400
X-MC-Unique: JEjw6ms_PxKY0E4QMeWkVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1044D1C008B8;
	Tue, 26 Mar 2024 20:17:42 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.204])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D91CC3C20;
	Tue, 26 Mar 2024 20:17:41 +0000 (UTC)
Date: Tue, 26 Mar 2024 16:17:22 -0400
From: Phil Auld <pauld@redhat.com>
To: Thijs Raymakers <thijs@raymakers.nl>
Cc: kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: [PATCH 0/1] coresched: Manage core scheduling cookies for tasks
Message-ID: <20240326201722.GF315070@lorien.usersys.redhat.com>
References: <20240326144129.GA315070@lorien.usersys.redhat.com>
 <20240326174909.117426-1-thijs@raymakers.nl>
 <20240326190910.GD315070@lorien.usersys.redhat.com>
 <c43ab992-9fb0-4b73-a542-71e4e8a86cf5@raymakers.nl>
 <20240326201618.GE315070@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326201618.GE315070@lorien.usersys.redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Tue, Mar 26, 2024 at 04:16:23PM -0400 Phil Auld wrote:
> On Tue, Mar 26, 2024 at 08:26:23PM +0100 Thijs Raymakers wrote:
> > Op 26-03-2024 om 20:09 schreef Phil Auld:
> > > I tried this version out and it doesn't work for me. One of the
> > > basic use cases of a wrapper like this is to run a command with
> > > a new cookie (say starting a container or something).
> > > 
> > > Coresched requires a pid to do that:
> > >  # ./coresched -n ls
> > >  coresched: Failed to parse PID for -n/--new: 'ls'   
> > > 
> > > With my coreset utility it does work and gives some information about what
> > > it did:
> > > 
> > >  # coreset -n ls
> > >  pid 20860's current cookie: 0x0
> > >  pid 20860's new cookie: 0xa9fcfbf1
> > >  ABOUT-NLS        chrt           configure      ionice        libsmartcols  Makefile.in
> > > ...
> > > 
> > > Did I miss something?  I think this will be one of the primary use cases for
> > > this utility.
> > 
> > Hi Phil,
> > 
> > The following command works
> > 
> > # ./coresched ls
> > chrt.1	    chrt.1.deps  coresched.1.adoc  coresched.o  ionice.1.adoc
> > ...
> 
> Hhm, I'd prefer the no argument case to be a noop. 
> 
> But okay, I was missing something :)  This is where some output might
> have helped though ...
> 
> So "-n/--new" creates a new cookie and so does "". Just one on an existing task
> and one on the exec'd task.  Seems inconsistent, no?
> 
> > 
> > By default, it will spawn the provided program with a new core
> > scheduling cookie.
> >
> 
> See above about default. But maybe that's just my taste.
> 
> Since you have expplicit commands to do things why not just make --get be
> the default no command one?  So coresched -p 1234  just reports the cookie
> of pid 1234 or corsched ls just reports (in this case the meaningless) cookie
> of the exec'd ls command.
> 
> The use the -n and friends as an action operation to create/copy etc.
> 
> 
> > This command
> > # ./coresched -n 123
> > 
> > is to assign a new core scheduling cookie to PID 123. The commands don't
> > show what the current and/or new cookie is, because that is of limited
> > utility in my opinion (and --get also does this).
> 
> Yes, true. But it's sometimes nice to see that the command you ran did
> something,
> 
> 
> But anyway, that's more of my 2 cents. I'll try it again with new
> knowledge.
>

Btw, did you try coreset to see if it does what you need?


Cheers,
Phil



> 
> Cheers,
> Phil
> 
> 
> 
> > You can only use it to check if two programs have the same cookie.
> > An error message will be printed and the exit code will be set if it
> > doesn't succeed. Otherwise,
> > if the program succeeds then it won't write anything to stderr/stdout.
> > 
> > Thijs
> > 
> 
> -- 

-- 

