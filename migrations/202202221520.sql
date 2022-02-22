CREATE TABLE files (
    id UUID NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    is_encrypted BOOLEAN NOT NULL DEFAULT false,
    public_short_code VARCHAR(63) NOT NULL,
    private_short_code VARCHAR(63) NOT NULL,
    stored_before TIMESTAMP(0) WITH TIME ZONE NOT NULL,
    placement VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
)