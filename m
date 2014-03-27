Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.130]:63555 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154AbaC0StW convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 27 Mar 2014 14:49:22 -0400
Date: Thu, 27 Mar 2014 19:49:12 +0100
From: Werner Baumann <werner.baumann@onlinehome.de>
To: util-linux@vger.kernel.org
Subject: Bug: libmount essentially undocumented
Message-ID: <20140327194912.33d74236@ginster.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While there is a documentation at
https://www.kernel.org/pub/linux/utils/util-linux/v2.24/libmount-docs/index.html
this documentation mainly consists of nice formatting with almost no
information about what the library functions are doing. Therefore the
library is essentially unusable (except for the maintainer of the
library).

Some examples:

* libmount Overview
"The libmount library is used to parse /etc/fstab, /etc/mtab
and /proc/self/mountinfo files, manage the mtab file, evaluate mount
options, etc."
That's all. Well, "etc" may be a good starting point.

* struct libmnt_context
This is a central object of the library, used by a zillion of
functions. While it is perfectly o.k. to hide the internals from the
public interface, it is not o.k. to have no description of this object
at all.
What kind of data will it hold (well, the context I know)?
What is its intended use? There is one example use case, without
explanation except:
"This code is similar to: mount -o
aaa,bbb,ccc=CCC,noatime,noexec /mnt/foo", nothing more.
Please not: it says "similar to", not "the same as". It's anyone's guess
what might be the difference.

* mnt_new_context ()
"struct libmnt_context * mnt_new_context (void);
 Returns : newly allocated mount context"
Nothing more. What's the initial state of the context. What values are
the mount options set to. The defaults from 'man mount'? All zeros? Is
all zeros the same as the defaults from 'man mount'?
What are necessary functions to apply before you can use the mount
context in a call of mnt_context_mount(), what is optional?

* mnt_context_prepare_mount ()
"int mnt_context_prepare_mount (struct libmnt_context *cxt);
 Prepare context for mounting, unnecessary for mnt_context_mount().
 cxt : context
 Returns : negative number on error, zero on success"
Is this all I have to do. How does this function know which file system
I want to mount?
More confusing: A inline comment in the nfs mount program (maintained
by the maintainer of libmount) says:
"The libmount strictly uses only options from fstab if running in restricted mode (suid, non-root user). This is done in mnt_context_prepare_mount() by default."
Why is this not mentioned in the documentation of
mnt_context_prepare_mount? And how does the library know whether it is
in "restricted mode"? mnt_context_apply_fstab too has no information on
this.

* mnt_context_set_options ()
"int mnt_context_set_options (struct libmnt_context *cxt, const char
*optstr);
 cxt : mount context
 optstr : comma delimited mount options
 Returns : 0 on success, negative number in case of error."
What will happen when this function is applied a second time? Will the
new options replace the old ones, or will the new options be merged
into the old ones? Naming the function "*_set_*" indicates replacement,
for merging I would expect a name with "_add_". But looking at the nfs
code it seems to add the new optons and not replace the old ones.

* By chance I noticed a new file on my system: "/var/run/mount/utab".
  Not worth mentioning? Funnily comments in the nfs code mention
  "/dev/.mount/utab" which I can't find on my system. Maybe udev will
  create it on occasion or is it just the same moved to another
  location?

I will stop the examples here. It's the same with almost all functions
in libmount. From the documentation you can't know what a function will
do, leave alone what preconditions must be met before applying a
function on the mount context.

I consider this bug serious because it renders the library unusable.

Cheers
Werner
