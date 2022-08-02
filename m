Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5E7C00140
	for <util-linux@archiver.kernel.org>; Tue,  2 Aug 2022 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiHBS1i (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Aug 2022 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiHBS1g (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Aug 2022 14:27:36 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703E62CE37
        for <util-linux@vger.kernel.org>; Tue,  2 Aug 2022 11:27:35 -0700 (PDT)
Received: from letrec.thunk.org (c-24-1-67-28.hsd1.il.comcast.net [24.1.67.28])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 272IRKTp006684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 Aug 2022 14:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1659464842; bh=evZ+rNSmD3rNp3jXO9ghUI0vgdkIYR1WUhckZ3mKod8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Wv0WHxgy6DhaI2eJ99S/BTwbsZEmFCy1tC0p7zSGsYXoUAF+labx5XNIYu0Vgc2f9
         xAiqP5elksM+zDtKx2d+phQMKetYY7PcZH9tX4uFZkUFzNstKjicJ6Jltbc0phk0Ie
         D4338YKqTJr2q+RkEpZ3zxCmw22sJQ27IdEtNlF50AAFbVb7PUtsuZRRhFlYauy4Ej
         70jFZDcXQx/+HJgyBMveajouN9lWMPG1NF65RfdoQwFvufo45rVAzZ+Zohax0RzNa2
         jcl0p1/MKTCEWp4ZE7VshxPj+c1q0H2/fkPcHMwmS4e5NrugW6Q3d/CgEtEKmNirEN
         frfxCxFE6xePA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 7053C8C3006; Tue,  2 Aug 2022 14:27:20 -0400 (EDT)
Date:   Tue, 2 Aug 2022 14:27:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Karel Zak <kzak@redhat.com>
Cc:     Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
Subject: Re: uuidd user / DynamicUser?
Message-ID: <YulsiH18GqtKYytp@mit.edu>
References: <20220730145024.gndtik3c24ivlukt@zeha.at>
 <20220802101423.t7uwcfa5cbfs3og7@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802101423.t7uwcfa5cbfs3og7@ws.net.home>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 02, 2022 at 12:14:23PM +0200, Karel Zak wrote:
> On Sat, Jul 30, 2022 at 04:50:24PM +0200, Chris Hofstaedtler wrote:
> > 
> > Debian sets up a uuidd user, for uuidd to run as. We also set the
> > home directory for this user to /run/uuidd, which is on a tmpfs, so
> > not ideal.
> >
> > I was wondering what other distributions do for the home directory?
>
> So it uses /var/lib/libuuid as a home directory.

Per RFC 4222, the clock sequence *should* be incremented under various
circumstances.  Setting to to a random value (which would be required
if you are using /run/uuidd) is *allowed*, but I would argue that this
is not as good, and not as in keeping with the design spirt of UUID
version 1:


4.1.5.  Clock Sequence

   For UUID version 1, the clock sequence is used to help avoid
   duplicates that could arise when the clock is set backwards in time
   or if the node ID changes.

   If the clock is set backwards, or might have been set backwards
   (e.g., while the system was powered off), and the UUID generator can
   not be sure that no UUIDs were generated with timestamps larger than
   the value to which the clock was set, then the clock sequence has to
   be changed.  If the previous value of the clock sequence is known, it
   can just be incremented; otherwise it should be set to a random or
   high-quality pseudo-random value.


   Similarly, if the node ID changes (e.g., because a network card has
   been moved between machines), setting the clock sequence to a random
   number minimizes the probability of a duplicate due to slight
   differences in the clock settings of the machines.  If the value of
   clock sequence associated with the changed node ID were known, then
   the clock sequence could just be incremented, but that is unlikely.


If system is using a read-only root, and doesn't want to maintain a
/var partition, which some systemd installations do care about --- but
for more traditional distributions, such as RHEL and Debian, my
personal recommendation is to not try to use /run/uuidd and using
a dynamic user for uuidd.

Cheers,

					- Ted
