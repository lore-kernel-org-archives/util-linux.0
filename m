Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773C37F75C
	for <util-linux@vger.kernel.org>; Wed,  8 Apr 2026 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775644552; cv=none; b=h7xprsTnZnMsxDuDYVJG9tzIlBI/YuhFPAVWQ96cyI9Us2X7oXomyFGkMwwUOdDsgBb0D1sI0OlrWhU6IIFLZeNo9Q01OP9HU1yDv5+Yeef9LUDu5BHqg17ORtOmCKJ3SI/NQBmTAcMFlwn6sjpKMOXl+hnstBto+nE1y3kfZ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775644552; c=relaxed/simple;
	bh=Rkg1Maz7twIyVdIfvelAkJXLrR+l1GeLSJLbxlvEug4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCKfuQeAcmGJYNqsYrbPlcYRq4dLc5YPvcpYy7tTJNaYx3yY9ErxCjn0RSIqsCxRlQazKZNH7vUntkaeZQNgh6JAP6Jdh8JNN5JnfgkHW+SRMTw+6hk8UZ/LgejLxDZpFdDyWW4oOed3gERGaJPpW+9OFjy/p4NJVYSHxT82ccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdatpucl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdatpucl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B45C19421;
	Wed,  8 Apr 2026 10:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775644550;
	bh=Rkg1Maz7twIyVdIfvelAkJXLrR+l1GeLSJLbxlvEug4=;
	h=From:To:Cc:Subject:Date:From;
	b=gdatpucljeGU2HAES+MlgvhM9snt7MjZSyxjfYLtPe9TjJnlrCQtl9rT8XIQgUQ2B
	 Ia4umdpsrNmmBkT8gTBJWCEUckd/vzihwiapomtFpG4P+c7kiywpFD9JsLrU8MMQLY
	 +odqH/fqWYgdObmWu/I9fz2SMSDySdLFGWPDq6yl1KsQ1fE9D6wtwl7L0xr3G3cVSo
	 lQMpAlYQPVptMSv6EMmS4YVnZIf5PaikqdCq/Ih7wddC8fWoiOekhyiPQsNzh4WwnI
	 LidpU0lqtFYc5rmPHd6qddCMadzA6rZz8U+BzmWpBXFJSEFrv0EjQOyoV1IoEeTN22
	 uVaUJ1R9GEIGQ==
From: cem@kernel.org
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org,
	zkabelac@redhat.com,
	amulhern@redhat.com
Subject: [PATCH RFC 0/2] Fix API breakage in libblkid
Date: Wed,  8 Apr 2026 12:35:24 +0200
Message-ID: <20260408103538.134308-1-cem@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

Patch d05a84b22e54 ("libblkid: check for private DM device before open")
broke blkid_new_probe_from_filename() API.

Before the patch users were able, via the low-level API, to open and
create blkid probes via the device's filename even from private
device-mapper devices.

This change broke Stratis project and xfsprogs.
xfsprogs uses blkid_new_probe_from_filename() to gather topology
information from the device, and the above mentioned change now prevents
it to be done on device-mapper private devices, as Stratis does by
attempting to initialize a XFS filesystem on it.

Quoting the patch description:

"
    blkid_new_probe_from_filename() opens the device before calling
    blkid_probe_set_device(), which checks sysfs_devno_is_dm_private()
    and sets BLKID_FL_NOSCAN_DEV.  But the open() itself bumps the
    kernel open count, so a concurrent DM_DEVICE_REMOVE ioctl sees
    EBUSY even though blkid never actually probes the device.
"

I don't think the last statement here is correct.
blkid_probe_set_device() marks the probe as BLKID_FL_NOSCAN_DEV, but it
does not error out, so, for low-level API calls, we simply ended up
with a probe with BLKID_FL_NOSCAN_DEV set. But the call succeeded and we
ended up with a probe to use and query device's information.

As far as I understood it, the patch aimed to close a possible race
window when issuing a DM_DEVICE_REMOVE ioctl() to the same device being
probed by blkid_new_probe_from_filename().

Regarding the race window which this patch, at least for the low-level
API users, this seems to be something that should be dealt in the user's
side, not within the library. But I didn't dig into the details of the
aforementioned race.

Please take the above with a grain of salt though, we've been using
libblkid for ages, but I never actually looked into the implementation
until today, so, hopefully I did get the details right.

As for xfsprogs, I have a patch which 'fixes' it replacing
blkid_new_probe_from_filename() by blkid_probe_set_device(), but this is
just taping over the root cause, which is the API breakage.


Carlos Maiolino (2):
  Revert "libblkid: add debug message for private DM device skip"
  Revert "libblkid: check for private DM device before open"

 libblkid/src/probe.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
-- 
2.53.0

