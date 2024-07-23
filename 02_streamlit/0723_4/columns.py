import streamlit as st

# Using object notation
add_selectbox = st.sidebar.selectbox(
    "How would you like to be contacted?", ("Email", "Home phone", "Mobile phone")
)

# Using "with" notation
with st.sidebar:
    add_radio = st.radio(
        "Choose a shipping method", ("Standard (5-15 days)", "Express (2-5 days)")
    )

    st.write(add_selectbox)
    st.write(add_radio)

col1, col2 = st.columns(2)
col1.write("Column 1")
col2.write("Column 2")

# Three columns with different widths
col1, col2, col3 = st.columns([3, 1, 1])
# col1 is wider

# Using 'with' notation:
with col1:
    st.image("https://i.imgur.com/MDKQoDc.jpg")
with col2:
    st.image("https://i.imgur.com/t2ewhfH.png")
with col3:
    st.image("https://i.imgur.com/ECROFMC.png")
