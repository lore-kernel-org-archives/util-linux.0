Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14253 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755AbaC1IwH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 28 Mar 2014 04:52:07 -0400
Date: Fri, 28 Mar 2014 09:52:00 +0100
From: Karel Zak <kzak@redhat.com>
To: Werner Baumann <werner.baumann@onlinehome.de>
Cc: util-linux@vger.kernel.org
Subject: Re: Bug: libmount essentially undocumented
Message-ID: <20140328085200.GE23464@x2.net.home>
References: <20140327194912.33d74236@ginster.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20140327194912.33d74236@ginster.fritz.box>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 27, 2014 at 07:49:12PM +0100, Werner Baumann wrote:
> * mnt_context_prepare_mount ()
> "int mnt_context_prepare_mount (struct libmnt_context *cxt);
>  Prepare context for mounting, unnecessary for mnt_context_mount().
>  cxt : context
>  Returns : negative number on error, zero on success"
> Is this all I have to do. How does this function know which file system
> I want to mount?

I'm not sure that we need this kind of babysitting, it's obvious that
there is probably a function to specify a filesystem.

> More confusing: A inline comment in the nfs mount program (maintained
> by the maintainer of libmount) says:

I'm author not maintainer of the helper.

> "The libmount strictly uses only options from fstab if running in restricted mode (suid, non-root user). This is done in mnt_context_prepare_mount() by default."
> Why is this not mentioned in the documentation of
> mnt_context_prepare_mount? And how does the library know whether it
> is in "restricted mode"? mnt_context_apply_fstab too has no
> information on this.

See mnt_context_is_restricted() ...

> * mnt_context_set_options ()
> "int mnt_context_set_options (struct libmnt_context *cxt, const char
> *optstr);
>  cxt : mount context
>  optstr : comma delimited mount options
>  Returns : 0 on success, negative number in case of error."
> What will happen when this function is applied a second time? Will the
> new options replace the old ones, or will the new options be merged
> into the old ones? Naming the function "*_set_*" indicates replacement,

mnt_context_set_options()
mnt_context_append_options()

> for merging I would expect a name with "_add_". But looking at the nfs
> code it seems to add the new optons and not replace the old ones.

it replaces old one, read the code again

> * By chance I noticed a new file on my system: "/var/run/mount/utab".
>   Not worth mentioning? Funnily comments in the nfs code mention
>   "/dev/.mount/utab" which I can't find on my system. Maybe udev will
>   create it on occasion or is it just the same moved to another
>   location?

well, the comment in NFS ode is obsolete, it's "/var/run/mount/utab".

> I will stop the examples here. It's the same with almost all functions
> in libmount. From the documentation you can't know what a function will
> do, leave alone what preconditions must be met before applying a
> function on the mount context.
> 
> I consider this bug serious because it renders the library unusable.

I'm absolutely agree that the documentation is really not perfect,
unfortunately now I have another priorities than improve the
documentation. 

Anyway it's open source, you can send patches, the docs is generated
from source code comments.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
